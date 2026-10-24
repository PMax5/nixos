{ ... }:

let
  domain = "pedromax.pt";
in
{
  services.nginx = {
    enable = true;

    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    recommendedGzipSettings = true;

    virtualHosts."dns.${domain}" = {
      forceSSL = true;
      useACMEHost = "dns.${domain}";

      locations."/".proxyPass = "http://127.0.0.1:3000";
    };

    virtualHosts."pdf.${domain}" = {
      forceSSL = true;
      useACMEHost = "pdf.${domain}";

      locations."/".proxyPass = "http://127.0.0.1:3005";
    };

    virtualHosts."assets.${domain}" = {
      forceSSL = true;
      useACMEHost = "assets.${domain}";

      locations."/".proxyPass = "http://127.0.0.1:8088";
    };

    virtualHosts."auth.${domain}" = {
      forceSSL = true;
      useACMEHost = "auth.${domain}";

      locations."/".proxyPass = "http://127.0.0.1:9091";
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
