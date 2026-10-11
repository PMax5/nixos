{ pkgs, ... }:

{
  imports = [
    ./acme.nix
    ./dns-resolution.nix
    ./nginx.nix
    ../dns.nix
  ];

  environment.systemPackages = with pkgs; [
    btop
    htop
    pciutils
    smartmontools
    usbutils
  ];

  networking.firewall.enable = true;

  services = {
    fstrim.enable = true;
    smartd.enable = true;
  };
}
