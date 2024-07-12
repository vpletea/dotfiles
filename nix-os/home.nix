### Goes to  ~/.config/home-manager/home.nix - no sudo required
{ config, pkgs, lib, unstablePkgs, ... }:
{

  # No need to change the version
  home.stateVersion = "24.05";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Home manager to manage itself
  programs.home-manager.enable = true;

  home = {
    username = "valentin";
    homeDirectory = "/home/valentin";
  };

  programs.vscode = {
    enable = true;
  }; 
  
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };

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
      kc = "k3d cluster create -p 80:80@loadbalancer -p 443:443@loadbalancer";
      kd = "k3d cluster delete";
      nr = "sudo nixos-rebuild switch";
      ne = "sudo nano /etc/nixos/configuration.nix";
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
