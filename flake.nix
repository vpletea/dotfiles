{
  description = "Multi OS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {  self, nixpkgs, nix-darwin, home-manager, ...  }:
  {
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
    nixpkgs.hostPlatform = "x86_64-darwin";
    # system.configurationRevision = self.rev or self.dirtyRev or null;
    modules = [
        ./modules/macos-config.nix
        ./modules/aliases.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."vali.pletea" = import ./modules/macos-home.nix;
        }
      ];
    };
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem  {
        system = "x86_64-linux";
        modules = [
        ./modules/nixos-config.nix
        ./modules/aliases.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."vali.pletea" = import ./modules/nixos-home.nix;
        }
      ];
    };
  };
}
