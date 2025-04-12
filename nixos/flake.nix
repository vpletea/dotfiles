{
  description = "Multi OS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {  self, nixpkgs, nix-darwin, home-manager, ...  }@inputs:
  let
    macos-username = "valentin.pletea";
    nixos-username = "valentin";
  in

  {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem  {
    system = "x86_64-linux";
    modules = [
        host.nix
        ../config/aliases.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users."${nixos-username}" = import user.nix;
        }
      ];
    };
  };
}
