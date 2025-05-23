{ pkgs, inputs, ...}:

{
  imports =
  [
    ../config/global.nix
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;

  # Homebrew packages - GUI apps not availbale in nix repo
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    brews = [
      "openssh"
    ];
    casks = [
      "adobe-acrobat-reader"
      "amazon-workspaces"
      "android-platform-tools"
      "bitwarden"
      "caffeine"
      "firefox"
      "google-chrome"
      "microsoft-edge"
      "rancher"
      "rectangle"
      "winbox"
    ];
  };


  # Macos quality of life settings
  system.startup.chime = false;
  system.defaults = {
    dock.mru-spaces = false;
    dock.minimize-to-application = true;
    dock.show-recents = false;
    dock.magnification = false;
    dock.tilesize = 40;
    dock.wvous-bl-corner = 1;
    dock.wvous-br-corner = 1;
    dock.wvous-tl-corner = 1;
    dock.wvous-tr-corner = 1;
    NSGlobalDomain.AppleShowAllFiles = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    finder.ShowPathbar = true;
    finder.FXPreferredViewStyle = "clmv";
    finder._FXShowPosixPathInTitle = true;
    screencapture.location = "~/Pictures";
  };
  # Enable touch id for sudo
  security.pam.services.sudo_local.touchIdAuth = true;
  # Zsh settings
  users.defaultUserShell = pkgs.zsh;
  programs.starship.enable = true;
  programs.zsh.enable = true;
}
