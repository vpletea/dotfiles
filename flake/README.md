# Flake build
        darwin-rebuild build --flake .#simple
        nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#simple
# Flake update
        nix --extra-experimental-features 'nix-command flakes' flake update
# Create flake
        nix flake init -t nix-darwin --extra-experimental-features "nix-command flakes"