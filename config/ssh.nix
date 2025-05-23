{ pkgs, lib, inputs, customArgs, ... }:

{
  # SSH setup
  programs.ssh = {
    enable = true;
    extraConfig = ''
    StrictHostKeyChecking no
    CanonicalizeHostname yes
    CanonicalDomains h-net.xyz
    AddKeysToAgent yes
    Host github.com
        User vpletea
        HostName github.com
    Host *.h-net.xyz
        User devops
    '';
  };
}
