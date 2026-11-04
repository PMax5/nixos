{ inputs, profiles, ... }:

{
  imports = [
    profiles.base
    profiles.server.server
    profiles.sshd
    profiles.dnsmasq
    inputs.disko.nixosModules.disko
    ./disko.nix
  ];

  networking = {
    hostName = "falcon";
    hostId = "41c0c197";
    useDHCP = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  system.stateVersion = "26.05";

  # Set the private key path for Agenix system decryption
  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];

  # Services
  services.tailscale = {
    extraUpFlags = [
      "--accept-routes"
    ];
  };

  services.dnsmasq.settings.listen-address = [
    "127.0.0.1"
    "192.168.1.75"
  ];
}
