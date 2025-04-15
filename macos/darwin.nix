{ inputs, macos-username, ...}:

system: let
  configuration = import ./module/configuration.nix;
  home-manager = import ./module/home-manager.nix { inherit inputs pkgs macos-username; };
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
  inputs.nix-darwin.lib.darwinSystem {
    inherit system;

    # modules: allows for reusable code
    modules = [
      configuration
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
  }