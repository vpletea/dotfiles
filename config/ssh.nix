{ pkgs, lib, inputs, customArgs, ... }:


{
  # SSH setup
  programs.ssh = {
    enable = true;
    extraConfig = ''
    CanonicalizeHostname yes
    CanonicalDomains h-net.xyz
    Host github.com
        User vpletea
        HostName github.com
    Host *.h-net.xyz
        User devops
    '';
  };
}
