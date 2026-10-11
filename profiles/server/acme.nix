{ config, ... }:

let
  domainConfig = import ./domains.nix;

  cloudflareCert = {
    group = "nginx";
    dnsProvider = "cloudflare";
    credentialFiles.CLOUDFLARE_DNS_API_TOKEN_FILE =
      config.age.secrets.cloudflareToken.path;
  };
in
{
  age.secrets.cloudflareToken.file = secrets."cloudflare/pedromax.pt.age".file;
  
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