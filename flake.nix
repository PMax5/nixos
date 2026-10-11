{
  description = "NixOS home server configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      
      hostSecretsDir = ./secrets;
      generators = import ./lib/generators.nix {
        inherit nixpkgs inputs hostSecretsDir;
      };
      profiles = generators.mkProfiles ./profiles;
      secrets = generators.mkSecrets hostSecretsDir;
    in
    {
      nixosConfigurations = generators.mkHosts {
        hostsDir = ./hosts;
        inherit profiles;
        extraModules = [
          inputs.agenix.nixosModules.default
        ];
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          inputs.disko.packages.${system}.disko
          inputs.agenix.packages.${system}.default
        ];
      };

      formatter.${system} = pkgs.alejandra;
    };
}
