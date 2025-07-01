{ pkgs, ... }:

{
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
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
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
