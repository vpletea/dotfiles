{ inputs, pkgs, macos-username, ...}:

{
  imports =
  [
    ../config/aliases.nix
    ../config/git.nix
    ../config/kitty.nix
    ../config/ssh.nix
    ../config/starship.nix
    ../config/tools.nix
    ../config/vscode.nix
    ../config/zsh.nix
  ];
  # No need to change the version
  home.stateVersion = "24.05";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ansible
    htop
    k3d
    kubectl
    kubernetes-helm
    terraform
    zsh-fzf-history-search
    zsh-fzf-tab
    zsh-nix-shell
  ];

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
