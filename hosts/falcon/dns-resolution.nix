{ ... }:

let
  scorpionIp = "100.87.13.6";
in
{
  services.dnsmasq = {
    settings = {
      address = [ "/pedromax.pt/192.168.0.102" ];
    };
  };

  services.nginx = {
    enable = true;
    streamConfig = ''
      server {
        listen 80;
        proxy_pass ${scorpionIp}:80;
      }
      server {
        listen 443;
        proxy_pass ${scorpionIp}:443;
      }
    '';
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    trustedInterfaces = [ "tailscale0" ];
  };
}