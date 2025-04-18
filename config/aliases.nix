{ pkgs, lib, inputs, customArgs, ... }:

{
  home.shellAliases = {
    ll = "ls -alh";
    grep = "grep -n --color";
    kc = "k3d cluster create -p 80:80@loadbalancer -p 443:443@loadbalancer";
    kd = "k3d cluster delete";
    amt = "docker run --name mesh-mini -p 3000:3000 brytonsalisbury/mesh-mini:amd64";
    cat = "${pkgs.bat}/bin/bat";
    ls = "${pkgs.eza}/bin/eza";
  };
}
