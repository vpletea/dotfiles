{ inputs, nixos-username, ...}:

system: let
  configuration = import ./module/configuration.nix;
  hardware-configuration = import /etc/nixos/hardware-configuration.nix; # copy this locally to no longer run --impure
  home-manager = import ./module/home-manager.nix { inherit inputs pkgs nixos-username; };
  pkgs = inputs.nixpkgs.legacyPackages.${system};

in
  inputs.nixpkgs.lib.nixosSystem {
    inherit system;

    # modules: allows for reusable code
    modules = [
      hardware-configuration
      configuration

      {
        # Define user account
        users.users."${nixos-username}" = {
          isNormalUser = true;
          description = nixos-username;
          extraGroups = [ "networkmanager" "wheel" "docker" ];
      };
      }

      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${nixos-username}" = home-manager;
      }
    ];
  }