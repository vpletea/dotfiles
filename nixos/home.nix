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

  # Vscode Setup
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      hashicorp.terraform
      catppuccin.catppuccin-vsc
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
      "editor.fontSize" = 16;
      "editor.fontFamily" = "'FiraCode Nerd Font', 'monospace', monospace";
      "terminal.integrated.fontSize" = 16;
      "terminal.integrated.fontFamily" = "'FiraCode Nerd Font', 'monospace', monospace";
      "telemetry.telemetryLevel" = "off";
      "update.showReleaseNotes" = false;

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
      amt = "docker run -d --name mesh-mini -p 3000:3000 brytonsalisbury/mesh-mini:amd64 && firefox http://localhost:3000 && docker stop mesh-mini";
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

  # Customize Gnome settings 
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "org.gnome.Terminal.desktop"
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