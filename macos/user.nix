{ pkgs, macos-username, ...}:

{
  imports =
  [
    ../config/common.nix
  ];
  # No need to change the version
  home.stateVersion = "24.05";
  
  home.packages = with pkgs; [
    openssh
  ];

  # User settings
  home.username = "${macos-username}";
  home.homeDirectory = "/Users/${macos-username}";
  home.sessionPath = [
  "/run/current-system/sw/bin"
  "$HOME/.nix-profile/bin"
  ];

  # Garbage control - removes older generations
  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 10d";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
