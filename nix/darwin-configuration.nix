{ config, pkgs, ... }:

{
  imports =
  [
    modules/system.nix
    modules/homebrew.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";
  # Define your hostname.
  networking.hostName = "macbook";
  nixpkgs.config.allowUnfree = true;

  # Packages installed system wide
  environment.systemPackages = with pkgs; [
    home-manager
  ];
  # Install nerdfonts
  fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  security.pam.enableSudoTouchIdAuth = true;
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;
}
