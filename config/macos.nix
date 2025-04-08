{ config, inputs, pkgs, lib, unstablePkgs, ...  }:
  let
    macos-username = "valentin.pletea";
  in
{
  nix.settings.experimental-features = "nix-command flakes";
  # Set your time zone.
  time.timeZone = "Europe/Bucharest";
  nixpkgs.config.allowUnfree = true;
  environment.pathsToLink = [ "/share/zsh" ];
  users.users."${macos-username}" = {
    name = "${macos-username}";
    home = "/Users/${macos-username}";
  };

  # nix.package = pkgs.nix;
  security.pam.services.sudo_local.touchIdAuth = true;
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;

  # Packages installed system wide
  environment.systemPackages = with pkgs; [
    ansible
    htop
    k3d
    kubectl
    kubernetes-helm
    terraform
    watch
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = [
      "adobe-acrobat-reader"
      "amazon-workspaces"
      "android-platform-tools"
      "caffeine"
      "firefox"
      "google-chrome"
      "microsoft-edge"
      "rancher"
      "rectangle"
      "skype"
      "winbox"
    ];
  };

  # Install nerdfonts
  fonts.packages =  with pkgs; [
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
  ];


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


}
