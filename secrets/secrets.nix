let
  hosts = {
    scorpion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII8rZ2aWz3Us9svqVxSOCrJ7pTsmVwD6Oe4+eRkGMSI1 root@scorpion";
  };
  users = {
    pmax_raptor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP+8XZ43fa4ARh2uI+V7eJ+4W2TbMDWoPMVAbpn1j8G+";
  };
in
{
  "cloudflare/pedromax.pt.age".publicKeys = [
    hosts.scorpion
    users.pmax_raptor
  ];
}
