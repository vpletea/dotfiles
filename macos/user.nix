{ inputs, pkgs, macos-username, ...}:

{
  imports =
  [
    ../config/tools.nix
  ];
  # No need to change the version
  home.stateVersion = "24.05";

  # Global shell
  programs.zsh.enable = true;
  programs.starship.enable = true;

  home.packages = with pkgs; [
    openssh
  ];

  # User settings
  home.username = "${macos-username}";
  home.homeDirectory = "/Users/${macos-username}";
	home.sessionPath = [
		"/run/current-system/sw/bin"
		"$HOME/.nix-profile/bin"
	];

  home.file = {
    ".config/git/config".source = ../config/git.conf;
    ".config/kitty/kitty.conf".source = ../config/kitty.conf;
    ".ssh/config".source = ../config/ssh.conf;
    ".config/starship.toml".source = ../config/starship.toml;
    ".zshrc".source = ../config/zshrc;
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
