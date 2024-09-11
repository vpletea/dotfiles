### Goes to  ~/.config/home-manager/home.nix - no sudo required
{ config, pkgs, lib, unstablePkgs, ... }:
{
  imports =
  [
    modules/git.nix
    modules/kitty.nix
    modules/ssh.nix
    modules/starship.nix
    modules/vscode.nix
    modules/zsh.nix
  ];

  # No need to change the version
  home.stateVersion = "24.05";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # User settings
  home = {
    username = "valentin.pletea";
    homeDirectory = "/Users/valentin.pletea";
  };

  # Garbage control - removes older generations
  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 10d";
  };

}
