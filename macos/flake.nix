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
    macos-hostname = "macbook";
  in

  {
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [
      ./host.nix
      {
        # Define your hostname.
        networking.hostName = "${macos-hostname}";
        # Define user account
        users.users."${macos-username}" = {
          name = "${macos-username}";
          home = "/Users/${macos-username}";
        };
      }
      home-manager.darwinModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs macos-username; };
          users."${macos-username}" = import ./user.nix;
        };
      }
      ];
    };
  };

}
