{ pkgs, ... }:

{
  # User installed packages
  home.packages = with pkgs; [
    git
    htop
    kitty
    mise
    nil
    nixd
    nerd-fonts.jetbrains-mono
    zed-editor
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
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.eza = {
    enable = true;

    git = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
      "--color=auto"
    ];
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
      style = "plain";
    };
  };
}
