{ inputs, profiles, ... }: 

{
  imports = [
    profiles.base
    profiles.server.server
    profiles.sshd
    inputs.disko.nixosModules.disko
    ./disk-config.nix
  ];

  networking = {
    hostId = "8425e349";
    useDHCP = true;
  };

  system.stateVersion = "26.05";
}