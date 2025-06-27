{ pkgs, inputs, nixos-username, lib, ...}:
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
  };

  home.file = {
    ".config/git/config".source = ../config/git.conf;
    ".config/kitty/kitty.conf".source = ../config/kitty.conf;
    ".ssh/config".source = ../config/ssh.conf;
    ".config/starship.toml".source = ../config/starship.toml;
    ".zshrc".source = ../config/zshrc;
  };

  # Customize Gnome settings
  dconf.settings = let inherit (lib.hm.gvariant) mkUint32; in {
    "org/gnome/desktop/input-sources/xkb-options = {
      "caps:escape" = true;
    };
    "org/gnome/system/location" = {
      enabled = true;
      };
    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "kitty.desktop"
        "org.gnome.Nautilus.desktop"
      ];
      disable-user-extensions = false;
      disabled-extensions = [
        "@as"
      ];
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
      ];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
        disable-overview-on-startup = true;
        custom-theme-shrink = true;
        };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = false;
      show-battery-percentage = true;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };
    "org/gnome/desktop/session" = {
      "idle-delay" = mkUint32 900;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      "sleep-inactive-ac-type" = "nothing";
      "sleep-inactive-battery-type" = "suspend";
      "sleep-inactive-battery-timeout" = 900;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      "binding" = "<Super>t";
      "command" = "kitty";
      "name" = "Terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      "binding" = "<Super>f";
      "command" = "firefox";
      "name" = "Firefox";
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };
  };

  # XDG Settings
  xdg = {
    # Set default apps
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "firefox.desktop" ];
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
        "image/png" = [ "org.gnome.Loupe.desktop" ];
        "image/gif" = [ "org.gnome.Loupe.desktop" ];
        "image/webp" = [ "org.gnome.Loupe.desktop" ];
        "image/tiff" = [ "org.gnome.Loupe.desktop" ];
        "image/x-tga" = [ "org.gnome.Loupe.desktop" ];
        "image/vnd-ms.dds" = [ "org.gnome.Loupe.desktop" ];
        "image/x-dds" = [ "org.gnome.Loupe.desktop" ];
        "image/bmp" = [ "org.gnome.Loupe.desktop" ];
        "image/vnd.microsoft.icon" = [ "org.gnome.Loupe.desktop" ];
        "image/vnd.radiance" = [ "org.gnome.Loupe.desktop" ];
        "image/x-exr" = [ "org.gnome.Loupe.desktop" ];
        "image/x-portable-bitmap" = [ "org.gnome.Loupe.desktop" ];
        "image/x-portable-graymap" = [ "org.gnome.Loupe.desktop" ];
        "image/x-portable-pixmap" = [ "org.gnome.Loupe.desktop" ];
        "image/x-portable-anymap" = [ "org.gnome.Loupe.desktop" ];
        "image/x-qoi" = [ "org.gnome.Loupe.desktop" ];
        "image/svg+xml" = [ "org.gnome.Loupe.desktop" ];
        "image/svg+xml-compressed" = [ "org.gnome.Loupe.desktop" ];
        "image/avif" = [ "org.gnome.Loupe.desktop" ];
        "image/heic" = [ "org.gnome.Loupe.desktop" ];
        "image/jxl" = [ "org.gnome.Loupe.desktop" ];
        };
    };
    # Hiding unawnted shortcuts from launcher
    desktopEntries = {
      htop = {
        name = "htop";
        exec = "";
        noDisplay = true;
      };
      auto-cpufreq-gtk = {
        name = "auto-cpufreq-gtk";
        exec = "";
        noDisplay = true;
      };
      cups = {
        name = "cups";
        exec = "";
        noDisplay = true;
      };
      vim = {
        name = "Vim";
        exec = "";
        noDisplay = true;
      };
    };
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
