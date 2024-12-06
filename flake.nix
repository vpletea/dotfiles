{
  description = "Multi OS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {  self, nixpkgs, nix-darwin, home-manager, ...  }:
  {
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
    # system.configurationRevision = self.rev or self.dirtyRev or null;
    modules = [
        ./config/macos-config.nix
        ./shared/aliases.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users."valentin.pletea" = import ./home/macos-home.nix;
        }
      ];
    };
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem  {
        system = "x86_64-linux";
        modules = [
        ./config/nixos-config.nix
        ./shared/aliases.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users."valentin" = import ./home/nixos-home.nix;
        }
      ];
    };
  };
}
