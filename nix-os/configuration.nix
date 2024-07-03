# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;  #### Use the space key at boot for generations menu
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  boot.kernelParams = ["quiet"];

  # Enable zfs support
  # boot.supportedFilesystems = [ "zfs" ];
  # boot.zfs.forceImportRoot = false;
  # networking.hostId = "4e98920d";
  
  # Define your hostname.
  networking.hostName = "nixos"; 

  # Enable networking
  networking.networkmanager.enable = true;

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
  
  # Setting favorite apps in gnome
  services.xserver.desktopManager.gnome = {
    extraGSettingsOverrides = ''
      [org.gnome.shell]
      favorite-apps=['firefox.desktop', 'code.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop']
    '';
  };  

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };
 
  # Configure printing
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  # Enable pcscd service for yubikey
  services.pcscd.enable = true;
  
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

  # Docker setup
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
  
  # Define user account
  users.users.valentin = {
    isNormalUser = true;
    description = "Valentin";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  ### Accelerated Video Playback
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

  # Packages installed in system profile. To search, run: nix search wget
  environment.systemPackages = with pkgs; [
    ansible
    bottles
    docker
    firefox
    git
    gnome.gnome-terminal
    gnomeExtensions.dash-to-dock
    google-chrome
    htop
    k3d
    kubectl
    kubectx
    kubernetes-helm
    plymouth
    terraform
    vim
    vlc
    vscode
    wget
    wine
    yubioath-flutter
  ];

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

  ## ZSH Setup
  programs.zsh = {
  enable = true;
  autosuggestions.enable = true;
  autosuggestions.extraConfig = {
    "ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE" = "20";
    "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE" = "fg=60";
  };
  # Set zsh prompt for zsh autocomplete with up arrow
  promptInit = ''
    autoload -Uz history-search-end
    zle -N history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-forward-end history-search-end
    bindkey "$terminfo[kcuu1]" history-beginning-search-backward-end
    bindkey "$terminfo[kcud1]" history-beginning-search-forward-end
    user=$(whoami | awk '{print $1}')
    if [[ $user = valentin ]]
    then
      ssh-add -q ~/.ssh/github.key
    fi  
  '';
  loginShellInit = "
  #Set favorite apps in dock and enable extensions
  dconf reset /org/gnome/shell/favorite-apps
  gnome-extensions enable dash-to-dock@micxgx.gmail.com
  ";
  syntaxHighlighting.enable = true;
  histFile = "$HOME/.histfile";
  histSize = 10000;
  enableBashCompletion = true;
  shellAliases = {
    ll = "ls -alh";
    ls = "ls --color=auto --group-directories-first";
    grep = "grep -n --color";
    kc = "k3d cluster create -p 80:80@loadbalancer -p 443:443@loadbalancer";
    kd = "k3d cluster delete";
    nr = "sudo nixos-rebuild switch";
    ne = "sudo nano /etc/nixos/configuration.nix";
    };
  };
  environment.pathsToLink = [ "/share/zsh" ];
  
  ## Starship prompt setup
  programs.starship = {
  enable = true;
  settings = {
     kubernetes = {
     disabled = false;
     };
   };
  };

  ## SSH setup
  programs.ssh = {
  startAgent = true;
  extraConfig = ''
    StrictHostKeyChecking no
    CanonicalizeHostname yes
    CanonicalDomains h-net.xyz
    Host *
      User devops
      IdentityFile ~/.ssh/homelab.key
    Host gitub
      HostName github.com
      User vpletea
      IdentityFile ~/.ssh/github.key
  '';
  };
  
  ## FZF Setup
  programs.fzf = {
    fuzzyCompletion = true;
  };

  # Set default shell to zsh
  users.defaultUserShell = pkgs.zsh;

  # Enable firewall
  networking.firewall.enable = true;

  # NixOS garbage control - remove older generations
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 14d";
  };

  # System autoupgrade and channel setup
  system = {
    autoUpgrade = {
      enable = true;
      dates = "monthly";
      channel = "https://channels.nixos.org/nixos-24.05";
    };
  };

  # Power settings
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  powerManagement.enable = true;

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


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
