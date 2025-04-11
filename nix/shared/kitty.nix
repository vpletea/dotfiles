{ pkgs, lib, inputs, customArgs, ... }:

{
  # Kitty settings
  programs.kitty = {
    enable = true;
    settings = {
      copy_on_select = "yes";
      scrollback_lines = "10000";
      detect_urls = "yes";
      remember_window_size = "yes";
      linux_display_server = "X11";
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_min_tabs = "2";
      enabled_layouts = "Tall, *";
    };
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "FiraCode Nerd Font";
      size = 15;
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
    };
    shellIntegration.enableZshIntegration = true;
  };
}
