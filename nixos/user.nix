{ pkgs, inputs, nixos-username, ...}:
{

    imports =
  [
    ../config/tools.nix
    ../config/vscode.nix
  ];

  # No need to change the version
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    bitwarden
    firefox
    gnomeExtensions.dash-to-dock
    google-chrome
    onlyoffice-desktopeditors
    vlc
    winbox4
  ];

  # User settings
  home = {
    username = "${nixos-username}";
    homeDirectory = "/home/${nixos-username}";
  };

  home.file = {
    ".config/git/config".source = ../config/git;
    ".config/kitty/kitty.conf".source = ../config/kitty;
    ".ssh/config".source = ../config/ssh;
    ".config/starship.toml".source = ../config/starship.toml;
    ".zshrc".source = ../config/zshrc;
  };

  # AutoUpgrade settings
  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "weekly";
  };

  # Garbage control - removes older generations
  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 10d";
  };
}
