{ nixpkgs, inputs, profiles }:

let
  lib = nixpkgs.lib;

  mkHost = {
    hostPath,
    system ? "x86_64-linux",
    extraModules ? [],
    specialArgs ? {},
  }:

    let
      hostname = builtins.baseNameOf (toString hostPath);
    in
    lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs profiles hostname;
      } // specialArgs;

      modules = [
        { networking.hostName = hostname; }
        hostPath
      ] ++ extraModules;
    };

  mkHosts = hostsDir:
    let
      entries = builtins.readDir hostsDir;

      hostNames = builtins.attrNames (
        lib.filterAttrs
          (_: type: type == "directory")
          entries
      );
    in
    lib.genAttrs hostNames (hostname:
      mkHost {
        hostPath = hostsDir + "/${hostname}";
      }
    );
in
{
  inherit mkHost mkHosts;
}