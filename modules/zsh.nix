{ pkgs, lib, inputs, customArgs, ... }:

{
  # User shell and prompt setup
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    history.extended = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    historySubstringSearch.searchUpKey = [
      "$terminfo[kcuu1]"
      "^[[A"
    ];
    historySubstringSearch.searchDownKey = [
      "$terminfo[kcud1]"
      "^[[B"
    ];
    initExtra = ''
      ssh-add -q ~/.ssh/github.key
    '';
  };
}
