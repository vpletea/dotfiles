{ pkgs, lib, inputs, customArgs, ... }:

{
  homebrew = {
    enable = true;
    casks = [
      "amazon-workspaces"
      "caffeine"
      "firefox"
      "google-chrome"
      "microsoft-edge"
      "rancher"
      "rectangle"
      "skype"
    ];
  };
}
