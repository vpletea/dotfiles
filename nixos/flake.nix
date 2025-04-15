{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ...}:

  let
    nixos-username = "valentin";
    host = import ./module/host.nix;
    hardware = import /etc/nixos/hardware-configuration.nix; # copy this locally to no longer run --impure
    user = import ./module/user.nix { inherit inputs  pkgs nixos-username; };
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in

  {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
    modules = [
      hardware
      host

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
        home-manager.users."${nixos-username}" = user;
      }
    ];
    };
  };
}
