{ pkgs, inputs, ...}:

{
  imports =
  [
    ../config/global.nix
    ../config/graphics.nix
    ../config/power.nix
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

  # Nixos specific zsh settings
  users.defaultUserShell = pkgs.zsh;
  programs.starship.enable = true;

  # Newtorking settings
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Packages installed system wide
  environment.systemPackages = with pkgs; [ # Use "sudo ventoy-web" for the Web GUI
    file-roller # File archiver
    gnome-console
    gnome-disk-utility
    nautilus # File manager
    htop
    loupe # Image viewer
    plymouth
    vim
  ];

  # Packages uninstalled system wide
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];

  # Docker setup
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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
