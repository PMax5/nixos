{
  serverAddress = "192.168.1.95";

  records = [
    # Hosted on Scorpion (uses serverAddress)
    { domain = "dns.pedromax.pt"; }
    { domain = "pdf.pedromax.pt"; }
    { domain = "assets.pedromax.pt"; }

    # Hosted on another machine (None yet)
  ];
}
