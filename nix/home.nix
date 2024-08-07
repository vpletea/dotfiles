### Goes to  ~/.config/home-manager/home.nix - no sudo required
{ config, pkgs, lib, unstablePkgs, ... }:
{
  # No need to change the version
  home.stateVersion = "24.05";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Home manager to manage itself
  programs.home-manager.enable = true;

  # User settings
  home = {
    username = "valentin";
    homeDirectory = "/home/valentin";
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

  ## ZSH Setup
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
  shellAliases = {
      ll = "ls -alh";
      ls = "ls --color=auto --group-directories-first";
      grep = "grep -n --color";
      amt = "docker run --name mesh-mini -p 3000:3000 brytonsalisbury/mesh-mini:amd64";
      kc = "k3d cluster create -p 80:80@loadbalancer -p 443:443@loadbalancer";
      kd = "k3d cluster delete";
      nr = "sudo nixos-rebuild switch";
      ne = "sudo nixos-rebuild edit";
      hs = "home-manager switch";
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
    userEmail = "notmyemail@gmail.com";
    userName = "vpletea";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  # Starship prompt setup
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      kubernetes = {
      disabled = false;
      };
    };
  };

  # Htop install
  programs.htop = {
    enable = true;
    settings.show_program_path = true;
  };

  # Customize Gnome settings
  dconf.settings = let inherit (lib.hm.gvariant) mkTuple mkUint32 mkVariant; in {
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
    };
  };

  # Set default apps
  xdg.mimeApps = {
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