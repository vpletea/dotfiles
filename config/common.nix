{ pkgs, lib, inputs, customArgs, ... }:

{
  home.packages = with pkgs; [
    git
    htop
    kitty
    mise
    nerd-fonts.jetbrains-mono
  ];
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
      "--color=auto"
    ];
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
      style = "plain";
    };
  };
  # Vscode Setup
  programs.vscode = {
    enable = true;
  #  package = pkgs.vscodium;
    mutableExtensionsDir = false;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = true;
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
        tamasfe.even-better-toml
        # Github Copilot
        github.copilot
        github.copilot-chat
      ];
      userSettings = {
        "diffEditor.ignoreTrimWhitespace" = false;
        "editor.bracketPairColorization.enabled" = true;
        "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono', 'monospace', monospace";
        "editor.fontSize" = 16;
        "editor.formatOnSave" = false;
        "editor.formatOnType" = true;
        "editor.guides.bracketPairs" = true;
        "editor.guides.highlightActiveIndentation" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.minimap.enabled" = false;
        "editor.tabSize" = 2;
        "extensions.autoCheckUpdates" = true;
        "extensions.ignoreRecommendations" = true;
        "files.insertFinalNewline" = false;
        "files.trimFinalNewlines" = true;
        "files.trimTrailingWhitespace" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "git.mergeEditor" = true;
        "gitblame.inlineMessageEnabled" = true;
        "telemetry.telemetryLevel" = "off";
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono', 'monospace', monospace";
        "terminal.integrated.fontSize" = 18;
        "update.mode" = "none";
        "update.showReleaseNotes" = false;
        "window.restoreWindows" = "folders";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.startupEditor" = "none";
        "workbench.editor.historyBasedLanguageDetection" = true;
        "workbench.editor.languageDetection" = true;
        "terminal.integrated.defaultProfile.osx" = "zsh";
      };
    };
  };
}
