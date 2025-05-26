{ inputs, pkgs, macos-username, ...}:

{
  imports =
  [
    # ../config/aliases.nix
    ../config/git.nix
    ../config/kitty.nix
    ../config/ssh.nix
    # ../config/starship.nix
    ../config/tools.nix
    ../config/vscode.nix
    # ../config/zsh.nix
  ];
  # No need to change the version
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    ansible
    htop
    k3d
    terraform
    nerd-fonts.jetbrains-mono
    # openssh
  ];

  # User settings
  home.username = "${macos-username}";
  home.homeDirectory = "/Users/${macos-username}";
	home.sessionPath = [
		"/run/current-system/sw/bin"
		"$HOME/.nix-profile/bin"
	];
  # Enable zsh and starship
  programs.zsh.enable = true;
  programs.starship.enable = true;

  home.file = {
    ".zshrc".source = ../config/zshrc;
    ".config/starship.toml".source = ../config/starship.toml;
  };

  # Garbage control - removes older generations
  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 10d";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
