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
    historySubstringSearch.searchDownKey = [
      "$terminfo[kcud1]"
    ];
    historySubstringSearch.searchUpKey = [
      "$terminfo[kcuu1]"
    ];
    initExtra = ''
      # autoload -Uz history-search-end
      # zle -N history-beginning-search-backward-end history-search-end
      # zle -N history-beginning-search-forward-end history-search-end
      # bindkey -e
      # bindkey "^[[A" history-beginning-search-backward-end
      # bindkey "^[[B" history-beginning-search-forward-end
      ssh-add -q ~/.ssh/github.key
    '';
  };
}
