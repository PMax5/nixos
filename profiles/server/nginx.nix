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

      
      locations."= /authelia" = {
        extraConfig = ''
          internal;
          proxy_pass http://127.0.0.1:9091/api/authz/auth-request;

          proxy_set_header X-Original-Method $request_method;
          proxy_set_header X-Original-URL $scheme://$http_host$request_uri;
          proxy_set_header X-Forwarded-For $remote_addr;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header X-Forwarded-Host $http_host;
          proxy_set_header X-Forwarded-URI $request_uri;

          proxy_set_header Content-Length "";
          proxy_set_header Connection "";
          proxy_pass_request_body off;
        '';
      };

      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        extraConfig = ''
          auth_request /authelia;
          error_page 401 =302 https://auth.pedromax.pt/?rd=$scheme://$http_host$request_uri;
        '';
      };
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

    virtualHosts."cerebrus.${domain}" = {
      forceSSL =  true;
      useACMEHost = "cerebrus.${domain}";

      locations."/" = {
        proxyPass = "http://127.0.0.1:8123";
        proxyWebsockets = true;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
