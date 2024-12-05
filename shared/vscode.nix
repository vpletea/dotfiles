{ pkgs, lib, inputs, customArgs, ... }:

{
  # Vscode Setup
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      # Theme
      catppuccin.catppuccin-vsc
      # Tools
      waderyan.gitblame
      oderwat.indent-rainbow
      # Languages
      bbenoist.nix
      hashicorp.terraform
      tim-koehler.helm-intellisense

    ];
    userSettings = {
      "diffEditor.ignoreTrimWhitespace" = false;
      "editor.bracketPairColorization.enabled" = true;
      "editor.fontFamily" = "'FiraCode Nerd Font', 'monospace', monospace";
      "editor.fontSize" = 15;
      "editor.formatOnSave" = false;
      "editor.formatOnType" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.minimap.enabled" = false;
      "editor.tabSize" = 2;
      "extensions.autoCheckUpdates" = false;
      "extensions.ignoreRecommendations" = true;
      "files.insertFinalNewline" = false;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;
      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;
      "git.mergeEditor" = true;
      "gitblame.inlineMessageEnabled" = true;
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.fontFamily" = "'FiraCode Nerd Font', 'monospace', monospace";
      "terminal.integrated.fontSize" = 15;
      "update.mode" = "none";
      "update.showReleaseNotes" = false;
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.startupEditor" = "none";
      "workbench.editor.historyBasedLanguageDetection" = true;
      "workbench.editor.languageDetection" = true;
    };
  };
}
