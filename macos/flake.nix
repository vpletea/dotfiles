{
  description = "MacOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

outputs = inputs @ { self, nixpkgs, nix-darwin, home-manager, ...}:

 let
    macos-username = "valentin.pletea";
    host = import ./module/host.nix;
    user = import ./module/user.nix { inherit inputs pkgs macos-username; };
    nixpkgs.hostPlatform = "aarch64-darwin";
    pkgs = inputs.nixpkgs.legacyPackages.${nixpkgs.hostPlatform};
  in

  {
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
    modules = [
      host

      {
        users.users."${macos-username}" = {
          name = "${macos-username}";
          home = "/Users/${macos-username}";
        };
      }
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${macos-username}" = home-manager;
      }
        ];
        };
    };
}
