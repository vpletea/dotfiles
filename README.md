# Howto Mac
- Install Nix using Determinate Systems installer: https://determinate.systems/nix-installer/
- Install Homebrew from:  https://brew.sh/
- Download the dotfiles repo
- Run the following commands in the repo:
  ```
  darwin-rebuild switch --flake .
  nix develop
  home-manager switch -b backup --flake .
  ```