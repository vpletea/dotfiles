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
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in

  {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      /etc/nixos/hardware-configuration.nix
      ./host.nix
      {
        # Define your hostname.
        networking.hostName = "${nixos-hostname}";
        # Define user account
        users.users."${nixos-username}" = {
          isNormalUser = true;
          description = nixos-username;
          extraGroups = [ "networkmanager" "wheel" "docker" ];
      };
      }
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${nixos-username}" = import ./user.nix { inherit inputs pkgs nixos-username; };
      }
      ];
    };
    # Expose the package set, including overlays, for convenience.
    nixosPackages = self.nixosConfigurations."${nixos-hostname}".pkgs;
  };
}
