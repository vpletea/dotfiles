# Dotfiles

Inspired by: [https://phelipetls.github.io/posts/introduction-to-ansible/](https://phelipetls.github.io/posts/introduction-to-ansible/)

Github sample: [https://github.com/phelipetls/dotfiles](https://github.com/phelipetls/dotfiles)

Old dotfiles repo: [https://dev.azure.com/vpletea/_git/Unsorted?path=/workstation-main](https://dev.azure.com/vpletea/_git/Unsorted?path=/workstation-main)

Steps:

- add/remove software
- symlink config files
- desktop customization

Software:

| **App Name** | **State** | **OS** | **Source** | **Mentions** |
| --- | --- | --- | --- | --- |
| *gnome-maps* | *remove* | *fedora* | *dnf* | *gnome maps* |
| *gnome-boxes* | *remove* | *fedora* | *dnf* | *Gnome boxes* |
| *yelp* | *remove* | *fedora* | *dnf* | *Gnome help* |
| *gnome-contacts* | *remove* | *fedora* | *dnf* | *Gnome contacts* |
| *gnome-abrt* | *remove* | *fedora* | *dnf* | *gnome bug report* |
| *gnome-characters* | *remove* | *fedora* | *dnf* | *gnome characters* |
| *snapshot* | *remove* | *fedora* | *dnf* | *gnome camera app* |
| *gnome-tour* | *remove* | *fedora* | *dnf* | *gnome tour app* |
| *totem* | *remove* | *fedora* | *dnf* | *gnome videos app* |
| *libreoffice-core* | *remove* | *fedora* | *dnf* | *libre office* |
| *rhythmbox* | *remove* | *fedora* | *dnf* | *music player* |
| *gnome-clocks* | *remove* | *fedora* | *dnf* | *clocks app* |
| *gnome-software* | *remove* | *fedora* | *dnf* | *software center install apps via cli* |
| podman | remove | fedora | dnf | replaced with docker |
| ansible | present | fedora/macos | brew |  |
| htop | present | fedora/macos | brew |  |
| k3d | present | fedora/macos | brew |  |
| kubectl | present | fedora/macos | brew |  |
| helm | present | fedora/macos | brew |  |
| terraform | present | fedora/macos | brew |  |
| watch | present | fedora/macos | brew |  |
| wget | present | fedora/macos | brew |  |
| fira code nerdfont | present | fedora/macos | brew |  |
| droid sans mono | present | fedora/macos | brew |  |
| android-tools | present | fedora | dnf |  |
| onlyoffice | present | fedora | brew | third party repo |
| vlc | present | fedora | dnf |  |
| kitty | present | macos | brew |  |
| kitty | present | fedora | dnf |  |
| zsh | present | fedora | dnf |  |
| starship | present | fedora | brew |  |
| starship | present | macos | brew |  |
| docker | present | fedora | dnf |  |
| vscode | present | fedora | dnf | third party repo |
| vscode | present | macos | brew |  |
| firefox | present | macos | brew |  |
| firefox | present | fedora | dnf |  |
|  adobe-acrobat-reader | present | macos | brew | cask |
| amazon-workspaces | present | macos | brew | cask |
| android-platform-tools | present | macos | brew | cask |
| caffeine | present | macos | brew | cask |
| google-chrome | present | macos | brew | cask |
| microsoft-edge | present | macos | brew | cask |
| rancher | present | macos | brew | cask |
| rectangle | present | macos | brew | cask |
| skype | present | macos | brew | cask |
| winbox | present | macos | brew | cask |
| gnome-extensions-app  | present | fedora | dnf |  |
| gnome-shell-extension-dash-to-dock  | present | fedora | dnf |  |
| google-chrome-stable | present | fedora | dnf | third party repo |
| winbox | present | fedora | script | [https://github.com/thiagoojack/winbox-fedora](https://github.com/thiagoojack/winbox-fedora) |
| file-roller | present | fedora | dnf | archive tool |

Symlinks:

- aliases
- git
- kitty
- ssh
- starship
- vscode
- zsh

Customizations:
- Gnome:

```
{ pkgs, lib, inputs, customArgs, ... }:

{

  # Customize Gnome settings
  dconf.settings = let inherit (lib.hm.gvariant) mkUint32; in {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "kitty.desktop"
        "org.gnome.Nautilus.desktop"
      ];
      disable-user-extensions = false;
      disabled-extensions = [
        "@as"
      ];
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
      ];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
        disable-overview-on-startup = true;
        custom-theme-shrink = true;
        };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = false;
      show-battery-percentage = true;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };
    "org/gnome/desktop/session" = {
      "idle-delay" = mkUint32 900;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      "sleep-inactive-ac-type" = "nothing";
      "sleep-inactive-battery-type" = "suspend";
      "sleep-inactive-battery-timeout" = 900;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      "binding" = "<Super>t";
      "command" = "kitty";
      "name" = "Terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      "binding" = "<Super>f";
      "command" = "firefox";
      "name" = "Firefox";
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };
  };

  # XDG Settings
  xdg = {
    # Set default apps
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "firefox.desktop" ];
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
        "image/png" = [ "org.gnome.Loupe.desktop" ];
        "image/gif" = [ "org.gnome.Loupe.desktop" ];
        "image/webp" = [ "org.gnome.Loupe.desktop" ];
        "image/tiff" = [ "org.gnome.Loupe.desktop" ];
        "image/x-tga" = [ "org.gnome.Loupe.desktop" ];
        "image/vnd-ms.dds" = [ "org.gnome.Loupe.desktop" ];
        "image/x-dds" = [ "org.gnome.Loupe.desktop" ];
        "image/bmp" = [ "org.gnome.Loupe.desktop" ];
        "image/vnd.microsoft.icon" = [ "org.gnome.Loupe.desktop" ];
        "image/vnd.radiance" = [ "org.gnome.Loupe.desktop" ];
        "image/x-exr" = [ "org.gnome.Loupe.desktop" ];
        "image/x-portable-bitmap" = [ "org.gnome.Loupe.desktop" ];
        "image/x-portable-graymap" = [ "org.gnome.Loupe.desktop" ];
        "image/x-portable-pixmap" = [ "org.gnome.Loupe.desktop" ];
        "image/x-portable-anymap" = [ "org.gnome.Loupe.desktop" ];
        "image/x-qoi" = [ "org.gnome.Loupe.desktop" ];
        "image/svg+xml" = [ "org.gnome.Loupe.desktop" ];
        "image/svg+xml-compressed" = [ "org.gnome.Loupe.desktop" ];
        "image/avif" = [ "org.gnome.Loupe.desktop" ];
        "image/heic" = [ "org.gnome.Loupe.desktop" ];
        "image/jxl" = [ "org.gnome.Loupe.desktop" ];
        };
    };
    # Hiding unawnted shortcuts from launcher
    desktopEntries = {
      htop = {
        name = "htop";
        exec = "";
        noDisplay = true;
      };
      auto-cpufreq-gtk = {
        name = "auto-cpufreq-gtk";
        exec = "";
        noDisplay = true;
      };
      cups = {
        name = "cups";
        exec = "";
        noDisplay = true;
      };
      vim = {
        name = "Vim";
        exec = "";
        noDisplay = true;
      };
    };
  };
}
```
- Macos:
```

  system.startup.chime = false;
  system.defaults = {
    dock.mru-spaces = false;
    dock.minimize-to-application = true;
    dock.show-recents = false;
    dock.magnification = false;
    dock.tilesize = 40;
    dock.wvous-bl-corner = 1;
    dock.wvous-br-corner = 1;
    dock.wvous-tl-corner = 1;
    dock.wvous-tr-corner = 1;
    NSGlobalDomain.AppleShowAllFiles = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    finder.ShowPathbar = true;
    finder.FXPreferredViewStyle = "clmv";
    finder._FXShowPosixPathInTitle = true;
    screencapture.location = "~/Pictures";
  };
```

Aliases:
```
    ll = "ls -alh";
    ls = "ls --color=auto";
    grep = "grep -n --color";
    kc = "k3d cluster create -p 80:80@loadbalancer -p 443:443@loadbalancer";
    kd = "k3d cluster delete";
    amt = "docker run --name mesh-mini -p 3000:3000 brytonsalisbury/mesh-mini:amd64";
```

Vscode:
```
    { pkgs, lib, inputs, customArgs, ... }:

    {
    # Vscode Setup
    programs.vscode = {
        enable = true;
        enableUpdateCheck = false;
        mutableExtensionsDir = true;
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
        # Github Copilot
        github.copilot
        github.copilot-chat
        ];
        userSettings = {
        "diffEditor.ignoreTrimWhitespace" = false;
        "editor.bracketPairColorization.enabled" = true;
        "editor.fontFamily" = "'FiraCode Nerd Font', 'monospace', monospace";
        "editor.fontSize" = 15;
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
```
Git:
```
  # Git setup
  programs.git = {
    enable = true;
    userEmail = "84437690+vpletea@users.noreply.github.com";
    userName = "vpletea";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
```

Bonus: .zshrc warning for uncommitted dotfiles - notify-send can send a desktop notification :

```bash
#!/bin/bash
cd "$(dirname "$0")"
dotfiles_check () {
    # Update the index
    git update-index -q --ignore-submodules --refresh
    err=0

    # Disallow unstaged changes in the working tree
    if ! git diff-files --quiet --ignore-submodules --
    then
        echo >&2 "cannot $1: you have unstaged changes."
        git diff-files --name-status -r --ignore-submodules -- >&2
        err=1
    fi

    # Disallow uncommitted changes in the index
    if ! git diff-index --cached --quiet HEAD --ignore-submodules --
    then
        echo >&2 "cannot $1: your index contains uncommitted changes."
        git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
        err=1
    fi

    if [ $err = 1 ]
    then
        echo >&2 "Please commit or stash them."
        exit 1
    fi
}
dotfiles_check

```