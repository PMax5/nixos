let
  hosts = {
    scorpion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICDits0HLrioEH5HoJssx+NERHj9OyRiNNU8TIXwI8Mr pmax@raptor";
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