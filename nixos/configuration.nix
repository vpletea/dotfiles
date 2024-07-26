### Goes to /etc/nixos/configuration.nix - requires sudo
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader setup
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;  #### Use the space key at boot for generations menu
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  boot.kernelParams = ["quiet"];

  # Enable ZFS support - enable for mounting truenas drives
  # boot.supportedFilesystems = [ "zfs" ];
  # boot.zfs.forceImportRoot = false;
  # networking.hostId = "4e98920d";
  
  # Define your hostname.
  networking.hostName = "nixos"; 

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Define user account
  users.users.valentin = {
    isNormalUser = true;
    description = "Valentin";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Install nerdfonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = [pkgs.xterm];
  
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # services.gnome.core-utilities.enable = false; 
 
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };
  
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Configure printing - for hp printers
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  # Enable pcscd service - required for yubikey
  services.pcscd.enable = true;

  # Docker setup
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
    
  # Allow unfree software
  nixpkgs.config.allowUnfree = true;
  
  # SSH agent setup
  programs.ssh = {
  startAgent = true;
  };

  # ZSH setup
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];
  
  # Starship prompt setup
  programs.starship = {
    enable = true;
  };

  # Accelerated Video Playback
  nixpkgs.config.packageOverrides = pkgs: {
     intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
   };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  # Packages installed system wide
  environment.systemPackages = with pkgs; [
    ansible
    bottles
    docker
    firefox
    git
    gnome.gnome-terminal
    gnomeExtensions.dash-to-dock
    google-chrome
    home-manager
    htop
    k3d
    kubectl
    kubectx
    kubernetes-helm
    plymouth
    terraform
    vim
    vlc
    wget
    wine
    yubioath-flutter
  ];

  # Packages uninstalled system wide
  environment.gnome.excludePackages = with pkgs; [
    gedit
    gnome-console
    gnome-photos
    gnome-text-editor
    gnome-tour
    gnome.atomix
    gnome.cheese
    gnome.epiphany
    gnome.evince
    gnome.geary
    gnome.gnome-calendar
    gnome.gnome-characters
    gnome.gnome-clocks
    gnome.gnome-contacts
    gnome.gnome-maps
    gnome.gnome-music
    gnome.hitori
    gnome.iagno
    gnome.seahorse
    gnome.simple-scan
    gnome.tali
    gnome.totem
    gnome.yelp
    snapshot
   ];

  # Power settings
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  powerManagement.enable = true;

  # TLP settings
  services.tlp = {
    enable = true;
    settings = {
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_BOOST_ON_AC = "1";
      CPU_BOOST_ON_BAT = "0";

      CPU_HWP_DYN_BOOST_ON_AC = "1";
      CPU_HWP_DYN_BOOST_ON_BAT = "0";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;

      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 30;
    };
  };

  # Enable firewall
  networking.firewall.enable = true;

  # NixOS garbage control - removes older generations
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 20d";
  };

  # System autoupgrade
  system = {
    autoUpgrade = {
      enable = true;
      dates = "monthly";
    };
  };
  # It‘s perfectly fine and recommended to leave this value 
  # at the release version of the first install of this system.
  system.stateVersion = "24.05";
}
