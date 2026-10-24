
{ config, hostSecretsDir, ... }:

let
  domain = "pedromax.pt";
in
{

  age.secrets = {
    authelia-jwt-secret = {
      file = "${hostSecretsDir}/authelia/jwt-secret.age";
      owner = "authelia-main";
    };

    authelia-session-secret = {
      file = "${hostSecretsDir}/authelia/session-secret.age";
      owner = "authelia-main";
    };

    authelia-storage-encryption-key = {
      file = "${hostSecretsDir}/authelia/storage-encryption-key.age";
      owner = "authelia-main";
    };

    authelia-users = {
      file = "${hostSecretsDir}/authelia/users.yml.age";
      owner = "authelia-main";
    };
  };

  services.authelia = {
    instances.main = {
      enable = true;

      secrets = {
        jwtSecretFile =
          config.age.secrets.authelia-jwt-secret.path;

        sessionSecretFile =
          config.age.secrets.authelia-session-secret.path;

        storageEncryptionKeyFile =
          config.age.secrets.authelia-storage-encryption-key.path;
      };

      settings = {
        theme = "auto";
        log.level = "info";

        server.address = "tcp://127.0.0.1:9091";

        authentication_backend.file.path =
          config.age.secrets.authelia-users.path;

        access_control = {
          default_policy = "deny";

          rules = [
            {
              domain = "auth.${domain}";
              policy = "bypass";
            }
            {
              domain = "*.${domain}";
              policy = "one_factor";
            }
          ];
        };

        session.cookies = [
          {
            inherit domain;
            authelia_url = "https://auth.${domain}";
          }
        ];

        storage.local.path = "/var/lib/authelia-main/db.sqlite3";

        notifier.filesystem.filename =
          "/var/lib/authelia-main/notifications.txt";
      };
    };
  };
}

