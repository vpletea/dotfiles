### Goes to  ~/.config/home-manager/home.nix - no sudo required
{ config, pkgs, lib, unstablePkgs, ... }:
{
  # No need to change the version
  home.stateVersion = "24.05";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # User settings
  home = {
    username = "valentin.pletea";
    homeDirectory = "/Users/valentin.pletea";
    shellAliases = {
      ll = "ls -alh";
      ls = "ls --color=auto";
      grep = "grep -n --color";
      kc = "k3d cluster create -p 80:80@loadbalancer -p 443:443@loadbalancer";
      kd = "k3d cluster delete";
      dr = "darwin-rebuild switch";
      hs = "home-manager switch -b backup";
    };
    packages = with pkgs; [
      ansible
      k3d
      kubectl
      kubernetes-helm
      terraform
      watch
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
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_min_tabs = "2";
      enabled_layouts = "Tall, *";
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
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "git.enableSmartCommit"= true;
      "git.confirmSync" = false;
      "git.mergeEditor" = true;
      "editor.formatOnType" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.bracketPairColorization.enabled" = true;
      "editor.minimap.enabled" = false;
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
}
