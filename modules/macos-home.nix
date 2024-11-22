### Goes to  ~/.config/home-manager/home.nix - no sudo required
{ config, inputs, pkgs, lib, unstablePkgs, ...  }:
{
  imports =
  [
    ./git.nix
    ./kitty.nix
    ./ssh.nix
    ./starship.nix
    ./vscode.nix
    ./zsh.nix
  ];
  # No need to change the version
  home.stateVersion = "24.05";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # User settings
  home.username = "vali.pletea";
  home.homeDirectory = "/Users/vali.pletea";
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
