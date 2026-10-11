{ nixpkgs, inputs, hostSecretsDir }:

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
        inherit inputs profiles hostname hostSecretsDir;
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
    extraModules ? [],
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
        inherit profiles system extraModules;
      }
    );

  mkSecrets = secretsDir:
    builtins.listToAttrs (builtins.map (file: let
        name = lib.removePrefix (toString secretsDir + "/") (toString file);
      in {
        inherit name;
        value = {inherit file;};
      })
      (builtins.filter (p: lib.hasSuffix ".age" p) (lib.filesystem.listFilesRecursive secretsDir)));
in
{
  inherit mkProfiles mkHost mkHosts mkSecrets;
}
