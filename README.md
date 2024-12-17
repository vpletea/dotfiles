# Flake installation
### MacOS
- Install Nix using Determinate Systems installer: https://determinate.systems/nix-installer/
- Install Homebrew from:  https://brew.sh/
- The flake can be installed directly:
  ```
  nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake github:vpletea/dotfiles#macos
  ```
- After the first run we can use:
  ```
  darwin-rebuild switch --flake github:vpletea/dotfiles#macos
  ```
  
### NixOS
- The flake can be installed directly:
  ```
  sudo nixos-rebuild switch --impure --flake github:vpletea/dotfiles#nixos
  ```
- Remove the nixos channel:
  ```
  sudo nix-channel --remove nixos
  ```
- Backup configuration.nix:
  ```
  sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.backup
  ```

### Updates
- On day 10, 20 and 30 of the month at 00:00 Github Actions updates the flake and creates a PR. To test the update before merging the PR run this:
  ```
  darwin-rebuild switch --flake github:vpletea/dotfiles/update_flake_lock_action#macos
  ```
  ```
  sudo nixos-rebuild switch --impure --flake github:vpletea/dotfiles/update_flake_lock_action#nixos
  ```
- To switch back to the lockfile on the main branch you can run:
  ```
  darwin-rebuild switch --flake github:vpletea/dotfiles#macos
  ```
  ```
  sudo nixos-rebuild switch --impure --flake github:vpletea/dotfiles#nixos
  ```    

# Local development  
### MacOS:
- Clone this repository
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
  
### NixOS:
- Clone this repository
- Install the flake:
  ```
  sudo nixos-rebuild switch --impure --flake .#nixos
  ```
- To update your configuration, you can run:
  ```
  nix flake update && sudo nixos-rebuild switch --impure --flake .#nixos

### Test branch:
   ```
  darwin-rebuild switch --flake github:vpletea/dotfiles/test#macos
  ```
  ```
  sudo nixos-rebuild switch --impure --flake github:vpletea/dotfiles/test#nixos
  ```
