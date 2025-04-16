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
      #Brew path for M1mac
      if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

      # Completion case unsesitive
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      # Disable menu completion
      zstyle ':completion:*' menu no

      # Shell integrations
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      source ${pkgs.zsh-fzf-history-search}/share/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh
    '';

  };
}
