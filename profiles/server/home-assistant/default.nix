{ config, hostSecretsDir, ... }:

{
  age.secrets.home-assistant-env = {
    file = "${hostSecretsDir}/homeassistant/secrets.env.age";
    owner = "root";
    mode = "0400";
  };

  virtualisation.oci-containers.containers.home-assistant = {
    image = "ghcr.io/home-assistant/home-assistant:2026.10.4";

    volumes = [
      "/var/lib/home-assistant:/config"
      "${./configuration.yaml}:/config/configuration.yaml:ro"
    ];

    environment = {
      TZ = "Europe/Lisbon";
    };

    environmentFiles = [
      config.age.secrets.home-assistant-env.path
    ];

    extraOptions = [
      "--network=host"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/home-assistant 0750 root root -"
  ];

  networking.firewall.allowedTCPPorts = [ 8123 ];
}
