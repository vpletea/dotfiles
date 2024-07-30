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
  
  # Alacritty settings
  programs.alacritty = {
    enable = true;
    settings = {
      # General settings
      font.normal.family = "FiraCode Nerd Font";
      font.size = 16;
      env = {
        TERM = "xterm-256color";
        XCURSOR_THEME = "Adwaita alacritty";
      };
      mouse.hide_when_typing= false;
      selection.save_to_clipboard = true;
      # Catppucing mocha theme
      colors.primary = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        dim_foreground = "#7f849c";
        bright_foreground = "#cdd6f4";
      };
      colors.cursor = {
        text = "#1e1e2e";
        cursor = "#f5e0dc";
      };
      colors.vi_mode_cursor = {
        text = "#1e1e2e";
        cursor = "#b4befe";
      };
        
      colors.search.matches = {
        foreground = "#1e1e2e";
        background = "#a6adc8";
      };

      colors.search.focused_match = {
        foreground = "#1e1e2e";
        background = "#a6e3a1";
      };

      colors.footer_bar = {
        foreground = "#1e1e2e";
        background = "#a6adc8";
      };

      colors.hints.start = {
        foreground = "#1e1e2e";
        background = "#f9e2af";
      };

      colors.hints.end = {
        foreground = "#1e1e2e";
        background = "#a6adc8";
      };

      colors.selection = {
        text = "#1e1e2e";
        background = "#f5e0dc";
      };

      colors.normal = {
        black = "#45475a";
        red = "#f38ba8";
        green = "#a6e3a1";
        yellow = "#f9e2af";
        blue = "#89b4fa";
        magenta = "#f5c2e7";
        cyan = "#94e2d5";
        white = "#bac2de";
      };

      colors.bright = {
        black = "#585b70";
        red = "#f38ba8";
        green = "#a6e3a1";
        yellow = "#f9e2af";
        blue = "#89b4fa";
        magenta = "#f5c2e7";
        cyan = "#94e2d5";
        white = "#a6adc8";
      };

      colors.dim = {
        black = "#45475a";
        red = "#f38ba8";
        green = "#a6e3a1";
        yellow = "#f9e2af";
        blue = "#89b4fa";
        magenta = "#f5c2e7";
        cyan = "#94e2d5";
        white = "#bac2de";
      };
    };
  };

  # # Kitty settings
  # programs.kitty = {
  #   enable = true;
  #   settings = {
  #     copy_on_select = "yes";
  #     scrollback_lines = "10000";
  #     detect_urls = "yes";
  #     remember_window_size = "yes";
  #   };
  #   theme = "Catppuccin-Mocha";
  #   font = {
  #     name = "FiraCode Nerd Font";
  #     size = 16;
  #   };
  # };
  
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

  # Starship prompt setup
  programs.starship = {
    settings = {
      kubernetes = {
      disabled = false;
      };
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
    userEmail = "vali.pletea@gmail.com";
    userName = "vpletea";
    diff-so-fancy.enable = true;
    lfs.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      merge = {
        conflictStyle = "diff3";
          tool = "meld";
        };
      pull = {
        rebase = false;
      };
    };
  };

  # Enable FZF
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };
  
  # Htop install
  programs.htop = {
    enable = true;
    settings.show_program_path = true;
  };
  
  # Customize Gnome settings 
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "Alacritty.desktop"
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
      dynamic-workspaces = true ;
    };
  }; 
}