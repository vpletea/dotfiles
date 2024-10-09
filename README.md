# Channels
        sudo nix-channel --add https://channels.nixos.org/nixos-24.05 nixos && sudo nixos-rebuild switch --upgrade
        nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager && nix-channel --update
# MacOS installation
        https://determinate.systems/posts/graphical-nix-installer/
        https://github.com/LnL7/nix-darwin
# Backup
        sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bkp
        mv ~/.config/home-manager/home.nix ~/.config/home-manager/home.nix.bkp

# Symlinks
        sudo ln -s $PWD/nixos/nixos-config.nix /etc/nixos/configuration.nix
        ln -s $PWD/nixos/nixos-home.nix ~/.config/home-manager/home.nix

        ln -s $PWD/macos/macos-config.nix ~/.nixpkgs/darwin-configuration.nix
        ln -s $PWD/macos/macos-home.nix ~/.config/home-manager/home.nix
