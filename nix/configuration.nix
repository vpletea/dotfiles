### Goes to /etc/nixos/configuration.nix - requires sudo
{ config, pkgs, lib, ... }:

{

  imports = [
      modules/aliases.nix
  ] ++
  (if (pkgs.system == "x86_64-linux")
    then [ /etc/nixos/hardware-configuration.nix ]
  else []);

    time.timeZone = "Europe/Bucharest";
    nixpkgs.config.allowUnfree = true;
    programs.zsh.enable = true;
    environment.pathsToLink = [ "/share/zsh" ];
    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ];

  environment.systemPackages = with pkgs; [
        home-manager
        ansible
        htop
        k3d
        kubectl
        kubernetes-helm
        terraform
        watch
    ] ++
    (if (pkgs.system == "x86_64-linux")
        then [
        gnomeExtensions.dash-to-dock
        ventoy-full # Use "sudo ventoy-web" for the Web GUI
        vlc
        yubioath-flutter
        firefox
        gnome.file-roller # File archiver
        gnome.gnome-disk-utility
        gnome.nautilus # File manager
        google-chrome
        loupe # Image viewer
        plymouth
        vim
    ]
    else []);

  homebrew = lib.mkIf (pkgs.system == "aarch64-darwin") {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = [
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
   services = lib.mkIf (pkgs.system == "aarch64-darwin") {
        nix-daemon.enable = true;
   };
    system.defaults = lib.mkIf (pkgs.system == "aarch64-darwin") {
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
   security.pam.enableSudoTouchIdAuth = lib.mkIf (pkgs.system == "aarch64-darwin") true;
   system.stateVersion = lib.mkIf (pkgs.system == "aarch64-darwin") 4;
}
