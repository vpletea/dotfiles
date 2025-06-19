{ pkgs, lib, inputs, customArgs, ... }:

{
  # Enable flakes support
  nix.settings.experimental-features = "nix-command flakes";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
