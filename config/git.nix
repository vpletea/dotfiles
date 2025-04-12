{ pkgs, lib, inputs, customArgs, ... }:

{
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
