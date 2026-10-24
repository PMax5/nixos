{ config, hostSecretsDir, ... }:

let
  oidc = import ./oidc-clients.nix;
  client = oidc.stirlingPdf;
in
{
  age.secrets.stirling-pdf-secrets = {
    file = "${hostSecretsDir}/stirling-pdf/secrets.env.age";
    owner = "root";
    mode = "0400";
  };

  virtualisation.oci-containers.containers.stirling-pdf = {
    image = "stirlingtools/stirling-pdf:3.1.0";
    autoStart = true;
    ports = ["127.0.0.1:3005:8080"];
    volumes = ["stirling_pdf_data:/configs"];
    environment = {
      DISABLE_ADDITIONAL_FEATURES = "false";
      SECURITY_ENABLELOGIN = "true";
      JAVA_TOOL_OPTIONS = "-XX:-UseCompactObjectHeaders -XX:MaxRAMPercentage=50.0 -XX:+UseG1GC";
      DOCKER_ENABLE_SECURITY = "true";
      SECURITY_OAUTH2_ENABLED = "true";
      SECURITY_OAUTH2_AUTOCREATEUSER = "true";
      SECURITY_OAUTH2_BLOCKREGISTRATION = "false";
      SECURITY_OAUTH2_PROVIDER = client.provider;
      SECURITY_OAUTH2_ISSUER = client.issuer;
      SECURITY_OAUTH2_CLIENTID = client.clientId;
      SECURITY_OAUTH2_SCOPES = "openid, profile, email";
      SECURITY_OAUTH2_USEASUSERNAME = "email";
    };
    environmentFiles = [
      config.age.secrets.stirling-pdf-secrets.path
    ];
  };
}
