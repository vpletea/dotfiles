{ pkgs, lib, nixos-username,  ...}:
{

    imports =
  [
    ../config/common.nix
  ];

  # No need to change the version
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    bitwarden
    firefox
    gnomeExtensions.dash-to-dock
    google-chrome
    onlyoffice-desktopeditors
    vlc
    winbox4
  ];
  # User settings
  home = {
    username = "${nixos-username}";
    homeDirectory = "/home/${nixos-username}";
    file = {".config/dconf/dconf.ini".source = ../config/dconf.ini;};
    activation.dconfSettings = lib.hm.dag.entryAfter ["writeBoundary"]
    ''
    run ${pkgs.dconf}/bin/dconf reset -f /
    run ${pkgs.dconf}/bin/dconf load / < /home/${nixos-username}/.config/dconf/dconf.ini
    '';
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
