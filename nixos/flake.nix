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
    nixos-system = import ./nixos.nix { inherit inputs nixos-username; };
  in

  {
    nixosConfigurations = {
      nixos = nixos-system "x86_64-linux";
    };
  };
}
