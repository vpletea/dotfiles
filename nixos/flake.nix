{
  description = "Multi OS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {  self, nixpkgs, home-manager, nix-vscode-extensions, ...  }@inputs:
  let
    macos-username = "valentin.pletea";
    nixos-username = "valentin";
  in

  {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem  {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
        ./host.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users."${nixos-username}" = import ./user.nix;
        }
      ];
    };
  };
}
