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

      locations."/".extraConfig = ''
        auth_request /authelia;

        error_page 401 =302 https://auth.${domain}/?rd=$scheme://$host$request_uri;
      '';

      locations."/authelia" = {
        extraConfig = ''
          internal;
          proxy_pass http://127.0.0.1:9091/api/authz/auth-request;
          proxy_pass_request_body off;
          proxy_set_header Content-Length "";

          proxy_set_header X-Original-URL $scheme://$http_host$request_uri;
          proxy_set_header X-Forwarded-Method $request_method;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header X-Forwarded-Host $http_host;
          proxy_set_header X-Forwarded-Uri $request_uri;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    '';
  };

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
