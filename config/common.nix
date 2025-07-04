{ pkgs, ... }:

{
  # User installed packages
  home.packages = with pkgs; [
    android-tools
    docker-client
    fzf
    git
    htop
    k3d
    kitty
    kubectl
    lima
    mise
    nil
    nixd
    nerd-fonts.jetbrains-mono
    starship
    zed-editor
    zoxide
  ];
  # User settings for various applications
  home.file = {
    ".config/git/config".source = ../config/git.conf;
    ".config/kitty/kitty.conf".source = ../config/kitty.conf;
    ".ssh/config".source = ../config/ssh.conf;
    ".config/starship.toml".source = ../config/starship.toml;
    ".config/zed/settings.json".source = ../config/zed.json;
    ".zshrc".source = ../config/zshrc;
  };
  # Useful programs
  programs.bat = {
    enable = true;
    config = {
      theme = "zenburn";
      style = "plain";
    };
  };
  programs.eza = {
    enable = true;
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
      "--color=auto"
    ];
  };
}
