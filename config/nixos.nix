{ config, pkgs, ... }:
  let
    username = "valentin";
  in
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
  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;
  # Enable ZFS support - enable for mounting truenas drives
  # boot.supportedFilesystems = [ "zfs" ];
  # boot.zfs.forceImportRoot = false;
  # networking.hostId = "4e98920d";

  # Define your hostname.
  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable flakes support
  nix.settings.experimental-features = "nix-command flakes";

  # Define user account
  users.users."${username}" = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Global shell and prompt setup
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];
  programs.starship.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = [pkgs.xterm];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-utilities.enable = false;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Packages installed system wide
  environment.systemPackages = with pkgs; [
    ansible
    gnomeExtensions.dash-to-dock
    k3d
    kubectl
    kubernetes-helm
    terraform
    ventoy-full # Use "sudo ventoy-web" for the Web GUI
    vlc
    yubioath-flutter
    firefox
    file-roller # File archiver
    gnome-console
    gnome-disk-utility
    nautilus # File manager
    google-chrome
    htop
    loupe # Image viewer
    plymouth
    vim
  ];

  # Packages uninstalled system wide
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];

  # Accelerated Video Playback
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  # Docker setup
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;

  # Install nerdfonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Configure printing - for hp printers
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  # Enable pcscd service - required for yubikey
  services.pcscd.enable = true;

  # SSH agent setup
  programs.ssh.startAgent = true;

  # Power settings
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  powerManagement.enable = true;

  # Auto-cpufreq settings
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
      energy_performance_preference = "balance_power";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  # Enable firewall
  networking.firewall.enable = true;

  # NixOS garbage control - removes older generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };

  # It‘s perfectly fine and recommended to leave this value
  # at the release version of the first install of this system.
  system.stateVersion = "24.05";
}
