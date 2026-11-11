{ config, pkgs, lib, ... }:

{
  services.dnsmasq = {
    enable = true;

    settings = {
      # Fallback default so it builds even if a host doesn't define it
      listen-address = lib.mkDefault [ "127.0.0.1" ];
      
      bind-interfaces = true;

      server = [
        "100.87.13.6"
      ];

      no-resolv = true;
      cache-size = 1000;
    };
  };
}
