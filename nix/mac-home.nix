### Goes to  ~/.config/home-manager/home.nix - no sudo required
{ config, pkgs, lib, unstablePkgs, ... }:
{
  imports =
  [
    modules/git.nix
    modules/kitty.nix
    modules/ssh.nix
    modules/starship.nix
    modules/vscode.nix
  ];

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
      htop
      k3d
      kubectl
      kubernetes-helm
      terraform
      watch
    ];
  };

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
      bindkey "^[[A" history-beginning-search-backward-end
      bindkey "^[[B" history-beginning-search-forward-end
      ssh-add -q ~/.ssh/github.key
    '';
  };

  # No need to change the version
  home.stateVersion = "24.05";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;
    # NixOS garbage control - removes older generations
  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 10d";
  };

}
