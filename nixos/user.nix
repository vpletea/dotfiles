{ pkgs, inputs, nixos-username, ...}:
{

    imports =
  [
    ../config/aliases.nix
    ../config/git.nix
    ../config/gnome.nix
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
    android-tools
    ansible
    authenticator
    gnomeExtensions.dash-to-dock
    k3d
    kubectl
    kubernetes-helm
    onlyoffice-desktopeditors
    terraform
    ventoy-full # Use "sudo ventoy-web" for the Web GUI
    vlc
    firefox
    google-chrome
    zsh-fzf-history-search
    zsh-fzf-tab
    zsh-nix-shell
  ];

  # User settings
  home = {
    username = "${nixos-username}";
    homeDirectory = "/home/${nixos-username}";
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
