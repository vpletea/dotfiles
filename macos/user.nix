{ inputs, pkgs, ...}:

{
  imports =
  [
    ../config/aliases.nix
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


  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # home.file = {
  #   ".zshrc".source = ../config/zshrc;
  # };



  # User settings
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
