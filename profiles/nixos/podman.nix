{ pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;

    # Create a `docker` alias for podman, to use it as a drop-in replacement
    dockerCompat = false;

    # Useful for Compose services communicating by container name.
    defaultNetwork.settings.dns_enabled = true;
  };

  oci-containers.backend = "podman";

  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}
