local wezterm = require 'wezterm'
return {
  color_scheme = 'Catppuccin Mocha',
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  font_size = 16.0,
  font = wezterm.font('JetBrainsMono Nerd Font Mono'),
  window_close_confirmation = 'NeverPrompt',
  skip_close_confirmation_for_processes_named = {
    'bash',
    'sh',
    'zsh',
    'fish',
    'tmux',
    'nu',
    'cmd.exe',
    'pwsh.exe',
    'powershell.exe',
  },
  mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}
