{ lib, ... }:

{
  services.openssh = {
    enable = true;
    openFirewall = true;

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      X11Forwarding = false;
      UseDns = false;
      StreamLocalBindUnlink = true;
    };

    # Only allow SSH keys explictly set here, in the NixOS configuration.
    authorizedKeysFiles = lib.mkForce [ "/etc/ssh/authorized_keys.d/%u" ];
  };

  users.users = {
    root.openssh.authorizedKeys.keys = import ./ssh-keys.nix;
    pmax.openssh.authorizedKeys.keys = import ./ssh-keys.nix;
  };
}