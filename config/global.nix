{ pkgs, lib, inputs, customArgs, ... }:

{
  # Enable flakes support
  nix.settings.experimental-features = "nix-command flakes";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Global shell and prompt setup
  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];
  programs.starship.enable = true;
}
