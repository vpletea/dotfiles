{ pkgs, ...}:

{
  # Enable flakes support
  nix.settings.experimental-features = "nix-command flakes";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader setup
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 0;  #### Use the space key at boot for generations menu
    plymouth.enable = true;
    initrd.systemd.enable = true;
    initrd.systemd.tpm2.enable = false;
    kernelParams = ["quiet"];
  };

  # Disable TPM2 support
  systemd.tpm2.enable = false;

  # Zsh settings
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Newtorking settings
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Packages installed system wide
  environment.systemPackages = with pkgs; [
    file-roller # File archiver
    gnome-console
    gnome-disk-utility
    nautilus # File manager
    loupe # Image viewer
    plymouth
    vim
  ];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    nil
    nixd
  ];

  # Packages uninstalled system wide
  environment.gnome.excludePackages = with pkgs; [ gnome-tour ];

  # Docker setup
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Configure printing - with drivers for hp printers
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  # SSH agent setup
  programs.ssh.startAgent = true;

  # Yubikey required service
  services.pcscd.enable = true;

  # Enable windowing system
  services.xserver = {
    enable = true;
    excludePackages = [pkgs.xterm];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # xkb.layout = "us";
    # xkb.variant = "";
  };
  services.gnome.core-apps.enable = false;

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

  # NixOS garbage control - removes older generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };

  # Leave this value at the release version of the first install of this system.
  system.stateVersion = "24.05";
}
