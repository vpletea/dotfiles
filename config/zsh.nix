{ pkgs, lib, inputs, customArgs, ... }:

{
  # User shell and prompt setup
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "zsh-fzf-history-search";
        src = "${pkgs.zsh-fzf-history-search}/share/zsh-fzf-history-search";
      }
    ];
    autosuggestion.enable = true;
    # history = {
    #   append = true;
    #   extended = true;
    #   share = true;
    #   ignoreAllDups = true;
    #   ignoreDups = true;
    #   ignoreSpace = true;
    #   saveNoDups = true;
    #   findNoDups = true;
    # };
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

      # Shell integrations
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      source ${pkgs.zsh-fzf-history-search}/share/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh

      # Shell integrations
      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"
    '';

  };
}
