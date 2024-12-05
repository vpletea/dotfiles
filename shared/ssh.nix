{ pkgs, lib, inputs, customArgs, ... }:

{
  # SSH setup
  programs.ssh = {
    enable = true;
    extraConfig = ''
    StrictHostKeyChecking no
    CanonicalizeHostname yes
    CanonicalDomains h-net.xyz
    Host github
      HostName github.com
      User vpletea
      IdentityFile ~/.ssh/github.key
    Host *
      User devops
      IdentityFile ~/.ssh/homelab.key
    '';
  };
}
