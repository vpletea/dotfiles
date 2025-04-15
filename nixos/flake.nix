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
    nixos-hostname = "nixos";
    pkgs = inputs.nixpkgs.legacyPackages.${nixpkgs.hostPlatform};
  in

  {
    nixosConfigurations."${nixos-hostname}" = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      /etc/nixos/hardware-configuration.nix
      ./module/host.nix
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
        home-manager.users."${nixos-username}" = import ./module/user.nix { inherit inputs pkgs nixos-username; };
      }
      ];
    };
  };
}
