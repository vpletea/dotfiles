{
  description = "Home Manager configuration of vali.pletea";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {  self, nixpkgs, nix-darwin, home-manager, ...  }:
    let
    mac-config = { pkgs, ... }: {
      nixpkgs.hostPlatform = "x86_64-darwin";
    };
    in {
      darwinConfigurations."Valis-iMac-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        mac-config
        ./modules/macos-config.nix
        ./modules/aliases.nix
        ];
      };

      homeConfigurations."vali.pletea" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-darwin";
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./modules/macos-home.nix ];
      };
    };
}
