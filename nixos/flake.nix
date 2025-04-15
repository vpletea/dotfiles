{
  description = "Example kickstart NixOS desktop environment.";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    # nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ...}:

  let
    nixos-username = "valentin";
    nixos-system = import ./nixos.nix { inherit inputs nixos-username; };
  in

  {
    nixosConfigurations = {
      x86_64 = nixos-system "x86_64-linux";
    };
  };
}