{ pkgs, lib, inputs, customArgs, ... }:

{
  # Vscode Setup
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      hashicorp.terraform
      catppuccin.catppuccin-vsc
      waderyan.gitblame
    ];
    userSettings = {
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "git.enableSmartCommit"= true;
      "git.confirmSync" = false;
      "git.mergeEditor" = true;
      "editor.formatOnType" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.bracketPairColorization.enabled" = true;
      "editor.minimap.enabled" = false;
      "editor.fontSize" = 15;
      "editor.fontFamily" = "'FiraCode Nerd Font', 'monospace', monospace";
      "terminal.integrated.fontSize" = 15;
      "terminal.integrated.fontFamily" = "'FiraCode Nerd Font', 'monospace', monospace";
      "telemetry.telemetryLevel" = "off";
      "update.showReleaseNotes" = false;
      "extensions.ignoreRecommendations" = true;
      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;
      "files.insertFinalNewline" = false;
      "diffEditor.ignoreTrimWhitespace" = false;
    };
  };
}
