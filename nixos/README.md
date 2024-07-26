# Channel management
        sudo nix-channel --add https://channels.nixos.org/nixos-24.05 nixos && sudo nixos-rebuild switch --upgrade
        nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager && nix-channel --update

# Symlinks to make working with git easier
        sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bkp
        sudo ln -s /home/valentin/coding/setup/nixos/configuration.nix /etc/nixos/configuration.nix
        mv /home/valentin/.config/home-manager/home.nix /home/valentin/.config/home-manager/home.nix.bkp
        ln -s /home/valentin/coding/setup/nixos/home.nix /home/valentin/.config/home-manager/home.nix 
