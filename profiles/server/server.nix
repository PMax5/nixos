{ pkgs, ... }:

{
  imports = [
    ./acme.nix
    ./authelia.nix
    ./dns-resolution.nix
    ./nginx.nix
    ./stirling-pdf.nix
    ./tailscale.nix
    ./wealthfolio.nix
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
