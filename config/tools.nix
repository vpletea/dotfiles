{ pkgs, lib, inputs, customArgs, ... }:

{
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
  home.packages = with pkgs; [
    mise
    nerd-fonts.jetbrains-mono
  ];
}
