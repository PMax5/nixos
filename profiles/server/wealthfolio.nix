{ config, hostSecretsDir, ... }:

{
  age.secrets.wealthfolio-secret-key.file = "${hostSecretsDir}/wealthfolio/secret-key.age";

  age.secrets.wealthfolio-auth-password-hash.file = "${hostSecretsDir}/wealthfolio/auth-password-hash.age";

  virtualisation.oci-containers.containers.wealthfolio = {
    image = "wealthfolio/wealthfolio:3.9";

    ports = [
      "127.0.0.1:8088:8088"
    ];

    volumes = [
      "wealthfolio_data:/data"
    ];

    environment = {
      WF_LISTEN_ADDR = "0.0.0.0:8088";
      WF_DB_PATH = "/data/wealthfolio.db";
      WF_CORS_ALLOW_ORIGINS = "http://localhost:8088";
      WF_OIDC_ISSUER_URL = "https://auth.pedromax.pt";
      WF_OIDC_CLIENT_ID = "wealthfolio";
      WF_OIDC_REDIRECT_URL = "https://assets.pedromax.pt/api/v1/auth/oidc/callback";
      WF_OIDC_SCOPES = "openid email profile";
      WF_OIDC_ALLOW_ANY = "true";
    };

    environmentFiles = [
      config.age.secrets.wealthfolio-secret-key.path
      config.age.secrets.wealthfolio-auth-password-hash.path
    ];
  };
}

