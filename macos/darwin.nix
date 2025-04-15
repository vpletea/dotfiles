{ inputs, macos-username, ...}:

system: let
  configuration = import ./module/configuration.nix;
  home-manager = import ./module/home-manager.nix { inherit inputs pkgs nixos-username; };
in
  inputs.nixpkgs.lib.darwinSystem {
    inherit system;

    # modules: allows for reusable code
    modules = [
      configuration
      {users.users.${macos-username}.home = "/Users/${macos-username}";}

      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${darwin-username}" = home-manager;
      }
    ];
  }