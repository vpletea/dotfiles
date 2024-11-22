# Howto Mac
- Install Nix using Determinate Systems installer: https://determinate.systems/nix-installer/
- Install Homebrew from:  https://brew.sh/
- Download the dotfiles repo in the home directory
- Install flake:
  ```
  nix --extra-experimental-features "nix-command flakes" build .#macos
  ./result/sw/bin/darwin-rebuild switch --flake ~/dotfiles
  ```
- After install we can use:
  ```
  darwin-rebuild switch --flake .#macos
  ```