### Goes to  ~/.config/home-manager/home.nix - no sudo required
{ config, pkgs, lib, unstablePkgs, ... }:
{
    imports =
  [
    ./git.nix
    ./gnome.nix
    ./kitty.nix
    ./ssh.nix
    ./starship.nix
    ./vscode.nix
    ./zsh.nix
  ];

  # No need to change the version
  home.stateVersion = "24.05";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # User settings
  home = {
    username = "valentin";
    homeDirectory = "/home/valentin";
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