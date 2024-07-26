# Symlinks to make working with git easier
        sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bkp
        sudo ln -s /home/valentin/coding/setup/nixos/configuration.nix /etc/nixos/configuration.nix
        mv /home/valentin/.config/home-manager/home.nix /home/valentin/.config/home-manager/home.nix.bkp
        ln -s /home/valentin/coding/setup/nixos/home.nix /home/valentin/.config/home-manager/home.nix 
