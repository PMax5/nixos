{ ... }:

{
  services.adguardhome = {
    enable = true;

    host = "127.0.0.1";
    port = 3000;

    openFirewall = false;

    settings = {
      filters = [
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt";
          name = "AdGuard DNS filter";
          id = 1;
        }
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_27.txt";
          name = "OISD Blocklist Big";
          id = 1780862686;
        }
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_44.txt";
          name = "HaGeZi's Threat Intelligence Feeds";
          id = 1780862687;
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
          name = "HaGeZi Multi PRO";
          id = 1780862688;
        }
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_3.txt";
          name = "AdGuard Tracking Protection";
          id = 1780862689;
        }
      ];

      dns = {
        # Listen for DNS queries on all IPv4 interfaces.
        # Restrict this to your LAN interface/IP if appropriate.
        bind_hosts = [ "0.0.0.0" ];
        port = 53;

        upstream_dns = [
          "tls://1.1.1.1"
          "tls://1.0.0.1"
        ];

        bootstrap_dns = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };
}
