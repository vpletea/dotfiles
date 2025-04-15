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
    darwin-system = import ./darwin.nix {inherit inputs macos-username;};
  in

  {
    darwinConfigurations = {
      macos = darwin-system "aarch64-darwin";
    };
  };
}
