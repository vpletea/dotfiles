{ config, inputs, pkgs, lib, unstablePkgs, ...  }:
  let
    macos-username = "valentin.pletea";
  in
{
  imports =
  [
    ../config/git.nix
    ../config/kitty.nix
    ../config/ssh.nix
    ../config/starship.nix
    ../config/vscode.nix
    ../config/zsh.nix
  ];
  # No need to change the version
  home.stateVersion = "24.05";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # User settings
  home.username = "${macos-username}";
  home.homeDirectory = "/Users/${macos-username}";
	home.sessionPath = [
		"/run/current-system/sw/bin"
		"$HOME/.nix-profile/bin"
	];
  # Garbage control - removes older generations
  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 10d";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
