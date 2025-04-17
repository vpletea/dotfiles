{ pkgs, lib, inputs, customArgs, ... }:

{
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
  };
  programs.bat = {
    enable = true;
    enableZshIntegration = true;
  };
}
