# Dotfiles

Annoyed by some Nix behaviours and Inspired by: [https://phelipetls.github.io/posts/introduction-to-ansible/](https://phelipetls.github.io/posts/introduction-to-ansible/)

Github sample: [https://github.com/phelipetls/dotfiles](https://github.com/phelipetls/dotfiles)

Enable Touch ID Sudo: https://derflounder.wordpress.com/2017/11/17/enabling-touch-id-authorization-for-sudo-on-macos-high-sierra/

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
| onlyoffice | present | fedora | dnf | third party repo | |
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
| android-platform-tools | present | macos/fedora | brew | cask |
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
