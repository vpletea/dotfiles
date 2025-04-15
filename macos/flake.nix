{
  description = "MacOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

outputs = inputs @ { self, nixpkgs, nix-darwin, home-manager, nix-vscode-extensions,  ...}:

 let
    macos-username = "valentin.pletea";
    macos-hostname = "macbook";
    pkgs = inputs.nixpkgs.legacyPackages.${nixpkgs.hostPlatform};
  in

  {
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [
      ./module/host.nix
      {
        # Define your hostname.
        networking.hostName = "${macos-hostname}";
        # Define user account
        users.users."${macos-username}" = {
          name = "${macos-username}";
          home = "/Users/${macos-username}";
        };
        nixpkgs.overlays = [
          nix-vscode-extensions.overlays.default
        ];
      }
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${macos-username}" = import ./module/user.nix { inherit inputs pkgs macos-username nix-vscode-extensions; };
      }
        ];
      };
    };
}
