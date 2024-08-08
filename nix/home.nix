### Goes to  ~/.config/home-manager/home.nix - no sudo required
{ config, pkgs, lib, unstablePkgs, ... }:
{
  # No need to change the version
  home.stateVersion = "24.05";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # User settings
  home = {
    username = "valentin";
    homeDirectory = "/home/valentin";
    shellAliases = {
      ll = "ls -alh";
      ls = "ls --color=auto --group-directories-first";
      grep = "grep -n --color";
      amt = "docker run --name mesh-mini -p 3000:3000 brytonsalisbury/mesh-mini:amd64";
      kc = "k3d cluster create -p 80:80@loadbalancer -p 443:443@loadbalancer";
      kd = "k3d cluster delete";
      nr = "sudo nixos-rebuild switch";
      ne = "sudo nixos-rebuild edit";
      hs = "home-manager switch -b backup";
    };
    packages = with pkgs; [
      ansible
      gnomeExtensions.dash-to-dock
      k3d
      kubectl
      kubernetes-helm
      terraform
      ventoy-full # Use "sudo ventoy-web" for the Web GUI
      vlc
      yubioath-flutter
    ];
  };

  # User shell and prompt setup
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    history.extended = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      autoload -Uz history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      bindkey "$terminfo[kcuu1]" history-beginning-search-backward-end
      bindkey "$terminfo[kcud1]" history-beginning-search-forward-end
      ssh-add -q ~/.ssh/github.key
    '';
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      kubernetes = {
      disabled = false;
      };
    };
  };

  # Kitty settings
  programs.kitty = {
    enable = true;
    settings = {
      copy_on_select = "yes";
      scrollback_lines = "10000";
      detect_urls = "yes";
      remember_window_size = "yes";
      linux_display_server = "X11";
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_bar_min_tabs = "2";
    };
    theme = "Catppuccin-Mocha";
    font = {
      name = "FiraCode Nerd Font";
      size = 15;
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
    };
    shellIntegration.enableZshIntegration = true;
  };

  # Vscode Setup
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      hashicorp.terraform
      catppuccin.catppuccin-vsc
      waderyan.gitblame
    ];
    userSettings = {
      "workbench.startupEditor"= "none";
      "workbench.colorTheme"= "Catppuccin Mocha";
      "git.enableSmartCommit"= true;
      "git.confirmSync"= false;
      "git.mergeEditor"= true;
      "editor.formatOnType"= true;
      "editor.inlineSuggest.enabled"= true;
      "editor.bracketPairColorization.enabled"=true;
      "editor.minimap.enabled"= false;
      "editor.fontSize" = 15;
      "editor.fontFamily" = "'FiraCode Nerd Font', 'monospace', monospace";
      "terminal.integrated.fontSize" = 15;
      "terminal.integrated.fontFamily" = "'FiraCode Nerd Font', 'monospace', monospace";
      "telemetry.telemetryLevel" = "off";
      "update.showReleaseNotes" = false;
      "extensions.ignoreRecommendations" = true;
      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;
      "files.insertFinalNewline" = false;
      "diffEditor.ignoreTrimWhitespace" = false;
    };
  };

  # SSH setup
  programs.ssh = {
    enable = true;
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

  # Git setup
  programs.git = {
    enable = true;
    userEmail = "84437690+vpletea@users.noreply.github.com";
    userName = "vpletea";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  # Customize Gnome settings
  dconf.settings = let inherit (lib.hm.gvariant) mkUint32; in {
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
    };
  };

  # AutoUpgrade settings
  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "weekly";
  };
    # NixOS garbage control - removes older generations
  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 10d";
  };
}