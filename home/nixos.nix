{ config, pkgs, lib, unstablePkgs, ... }:
  let
    nixos-username = "valentin";
  in
{
    imports =
  [
    ../shared/git.nix
    ../shared/gnome.nix
    ../shared/kitty.nix
    ../shared/ssh.nix
    ../shared/starship.nix
    ../shared/vscode.nix
    ../shared/zsh.nix
  ];

  # No need to change the version
  home.stateVersion = "24.05";

  # # Allow unfree software
  # nixpkgs.config.allowUnfree = true;

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
