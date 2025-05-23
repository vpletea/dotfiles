{ pkgs, lib, inputs, customArgs, ... }:
{
  # User shell and prompt setup
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      kubernetes = {
      disabled = false;
      };
    };
  };
}
