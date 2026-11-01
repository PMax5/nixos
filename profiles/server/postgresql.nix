{ pkgs, lib, ... }:

{
  services.postgresql = {
    enable = true;

    # Pin the major version for predictable upgrades.
    package = pkgs.postgresql_17;

    # Allow TCP connections only from the server itself.
    enableTCPIP = true;
    settings.listen_addresses = lib.mkForce "127.0.0.1";
  };
}

