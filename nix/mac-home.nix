### Goes to  ~/.config/home-manager/home.nix - no sudo required
{ config, pkgs, lib, unstablePkgs, ... }:
{
  imports =
  [
    modules/zsh.nix
    modules/home.nix
    modules/starship.nix
    modules/kitty.nix
    modules/vscode.nix
    modules/ssh.nix
    modules/git.nix
  ];
  # No need to change the version
  home.stateVersion = "24.05";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

}
