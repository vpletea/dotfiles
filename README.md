# Howto Mac
- Install Nix using Determinate Systems installer: https://determinate.systems/nix-installer/
- Install Homebrew from:  https://brew.sh/
- Clone the dotfiles repo in home directory
- Install flake:
  ```
   nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#macos
  ```
- After install we can use:
  ```
  darwin-rebuild switch --flake .#macos
  ```
- To update your configuration, you can run:
  ```
  nix flake update && darwin-rebuild switch --flake .#macos
  ```
- Alternatively the flake can be installed directly:
  ```
  nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake github:vpletea/dotfiles#macos
  ```

# Howto Nixos
- Remove the nixos channel:
  ```
  sudo nix-channel --remove nixos
  ```
- Backup configuration.nix:
  ```
  sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.backup
  ```
- Temporary run git:
  ```
  nix-shell -p git
  ```
- Clone the dotfiles repo in home directory
- Install the flake:
  ```
  nixos-rebuild switch --impure --flake .#nixos
  ```
- To update your configuration, you can run:
  ```
  nix flake update && nixos-rebuild switch --impure --flake .#nixos
  ```
- Alternatively the flake can be installed directly:
  ```
  nixos-rebuild switch --impure --flake github:vpletea/dotfiles#nixos
  ```
