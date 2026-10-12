{ ... }:

{
  services.nginx = {
    enable = true;

    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    recommendedGzipSettings = true;

    virtualHosts."dns.pedromax.pt" = {
      forceSSL = true;
      useACMEHost = "dns.pedromax.pt";

      locations."/".proxyPass = "http://127.0.0.1:3000";
    };

    virtualHosts."pdf.pedromax.pt" = {
      forceSSL = true;
      useACMEHost = "pdf.pedromax.pt";

      locations."/".proxyPass = "http://127.0.0.1:3005";
    };

    virtualHosts."assets.pedromax.pt" = {
      forceSSL = true;
      useACMEHost = "assets.pedromax.pt";

      locations."/".proxyPass = "http://127.0.0.1:8088";
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
