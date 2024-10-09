{ pkgs, lib, inputs, customArgs, ... }:

{
  environment.shellAliases = {
    ll = "ls -alh";
    ls = "ls --color=auto";
    grep = "grep -n --color";
    kc = "k3d cluster create -p 80:80@loadbalancer -p 443:443@loadbalancer";
    kd = "k3d cluster delete";
    amt = "docker run --name mesh-mini -p 3000:3000 brytonsalisbury/mesh-mini:amd64";
    dr = "darwin-rebuild switch";
    nr = "sudo nixos-rebuild switch";
    ne = "sudo nixos-rebuild edit";
    hs = "home-manager switch -b backup";
  };
}
