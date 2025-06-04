{ pkgs, inputs, nixos-username, ...}:
{

    imports =
  [
    ../config/git.nix
    ../config/gnome.nix
    ../config/kitty.nix
    ../config/ssh.nix
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
    ".zshrc".source = ../config/zshrc;
    ".config/starship.toml".source = ../config/starship.toml;
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
