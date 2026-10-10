
{ pkgs, inputs, ... }:

{
  # Nix store maintenance and defaults
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.unstable;
    };

    settings = {
      keep-outputs = true;
      keep-derivations = true;
      fallback = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };

  # Bootloader: EFI + systemd-boot
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.editor = false;
    efi.canTouchEfiVariables = true;
  };

  # Common utilities
  environment = {
    systemPackages = with pkgs; [
      # Editors
      neovim

      # Networking
      whois

      # System tools
      tmux
      curl
      git
      lsof
      ripgrep
      tree
      fastfetch
    ];

    variables.EDITOR = "nvim";
  };

  # User account
  programs.zsh.enable = true;

  users = {
    mutableUsers = true;

    users.pmax = {
      isNormalUser = true;
      createHome = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
    };
  };

  # Convenience setting; consider requiring a password instead.
  security.sudo.wheelNeedsPassword = false;
}
