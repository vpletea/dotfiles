### Goes to  ~/.config/home-manager/home.nix - no sudo required
{ config, pkgs, lib, unstablePkgs, ... }:
{
    imports =
  [
    modules/git.nix
    modules/gnome.nix
    modules/kitty.nix
    modules/ssh.nix
    modules/starship.nix
    modules/vscode.nix
  ];
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