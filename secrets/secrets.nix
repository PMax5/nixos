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

  "wealthfolio/secret-key.age".publicKeys = [
    hosts.scorpion
    users.pmax_raptor
  ];

  "wealthfolio/auth-password-hash.age".publicKeys = [
    hosts.scorpion
    users.pmax_raptor
  ];

  "authelia/jwt-secret.age".publicKeys = [
    hosts.scorpion
    users.pmax_raptor
  ];

  "authelia/session-secret.age".publicKeys = [
    hosts.scorpion
    users.pmax_raptor
  ];

  "authelia/storage-encryption-key.age".publicKeys = [
    hosts.scorpion
    users.pmax_raptor
  ];

  "authelia/users.yml.age".publicKeys = [
    hosts.scorpion
    users.pmax_raptor
  ];
}
