{ config, hostSecretsDir, ... }:

let
  domainConfig = import ./dns-records.nix;

  cloudflareCert = {
    group = "nginx";
    dnsProvider = "cloudflare";
    credentialFiles.CLOUDFLARE_DNS_API_TOKEN_FILE =
      config.age.secrets.cloudflareToken.path;
  };
in
{
  age.secrets.cloudflareToken.file = "${hostSecretsDir}/cloudflare/pedromax.pt.age";
  
  security.acme = {
    acceptTerms = true;
    defaults.email = "servers@pedromax.pt";

    certs = builtins.listToAttrs (
      map (record: {
        name = record.domain;
        value = cloudflareCert;
      }) domainConfig.records
    );
  };
}
