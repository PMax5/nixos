{ nixpkgs, inputs }:

let
  lib = nixpkgs.lib;

  mkProfiles = dir:
    let
      entries = builtins.readDir dir;
      names = builtins.attrNames entries;

      profile = name:
        let
          path = dir + "/${name}";
          type = entries.${name};
        in
        if type == "directory" then
          lib.nameValuePair name (mkProfiles path)
        else if lib.hasSuffix ".nix" name && name != "default.nix" then
          lib.nameValuePair (lib.removeSuffix ".nix" name) (import path)
        else
          null;
    in
    builtins.listToAttrs (
      builtins.filter (x: x != null) (map profile names)
    );

  mkHost = {
    hostPath,
    profiles,
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

  mkHosts = {
    hostsDir,
    profiles,
    system ? "x86_64-linux",
  }:
    let
      entries = builtins.readDir hostsDir;
      hostNames = builtins.attrNames (
        lib.filterAttrs (_: type: type == "directory") entries
      );
    in
    lib.genAttrs hostNames (hostname:
      mkHost {
        hostPath = hostsDir + "/${hostname}";
        inherit profiles system;
      }
    );
in
{
  inherit mkProfiles mkHost mkHosts;
}