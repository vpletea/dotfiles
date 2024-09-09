{ pkgs, lib, inputs, customArgs, ... }:

{
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
}
