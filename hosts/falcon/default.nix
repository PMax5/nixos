{ inputs, profiles, ... }:

{
  imports = [
    profiles.base
    profiles.sshd
    profiles.dnsmasq
    profiles.server.tailscale
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
      "--accept-dns=false"
    ];
  };

  services.dnsmasq.settings.listen-address = [
    "127.0.0.1"
    "100.79.87.19"
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
}
