{ config, inputs, pkgs, lib, unstablePkgs, ...  }:
{ 
  username = "valentin.pletea";
  homeDirectory = "/Users/${username}";
  imports =
  [
    ../shared/git.nix
    ../shared/kitty.nix
    ../shared/ssh.nix
    ../shared/starship.nix
    ../shared/vscode.nix
    ../shared/zsh.nix
  ];
  # No need to change the version
  home.stateVersion = "24.05";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # User settings
  home.username = "${username}";
  home.homeDirectory = homeDirectory;
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
