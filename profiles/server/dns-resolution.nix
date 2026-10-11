{ ... }:

let
  domainConfig = import ./dns-records.nix;

  rewrites = map (record: {
    domain = record.domain;
    answer = record.address or domainConfig.serverAddress;
  }) domainConfig.records;
in
{
  services.adguardhome.settings.filtering.rewrites = rewrites;
}
