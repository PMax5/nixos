{ inputs, profiles, ... }: 

{
  imports = [
    profiles.base
    profiles.server.server
    profiles.sshd
    inputs.disko.nixosModules.disko
    ./disko.nix
  ];

  networking = {
    hostName = "scorpion";
    hostId = "8425e349";
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
    useRoutingFeatures = "server";

    extraUpFlags = [
      "--advertise-routes=192.168.1.0/24"
    ];
  };

  networking.firewall.checkReversePath = "loose";
}
