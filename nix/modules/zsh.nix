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
    initExtra = ''
      multibind () {  # <cmd> <in-string> [<in-string>...]
          emulate -L zsh
          local cmd=$1; shift
          for 1 { bindkey $1 $cmd }
      }
      autoload -Uz history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      multibind history-beginning-search-backward-end '$terminfo[kcuu1]' '^[[A'  # up
      multibind history-beginning-search-forward-end  '$terminfo[kcud1]' '^[[B'  # down
      ssh-add -q ~/.ssh/github.key
    '';
  };
}
