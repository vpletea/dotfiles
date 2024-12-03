{ config, inputs, pkgs, lib, unstablePkgs, ...  }:

{
  nix.settings.experimental-features = "nix-command flakes";
  # Set your time zone.
  time.timeZone = "Europe/Bucharest";
  nixpkgs.config.allowUnfree = true;
  environment.pathsToLink = [ "/share/zsh" ];
  users.users."vali.pletea" = {
    name = "vali.pletea";
    home = "/Users/vali.pletea";
  };
  home-manager.backupFileExtension = "backup";
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  security.pam.enableSudoTouchIdAuth = true;
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;

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

  # Install nerdfonts
  fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
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
      "caffeine"
      "firefox"
      "google-chrome"
      "microsoft-edge"
      "rancher"
      "rectangle"
      "skype"
    ];
  };

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
  };


}
