# Howto MacOS
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
- To update your configuration, you can run:
  ```
  nix flake update && darwin-rebuild switch --flake .#macos
  ```  
  
# Howto NixOS
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
- To update your configuration, you can run:
  ```
  nix flake update && sudo nixos-rebuild switch --impure --flake .#nixos
  ```  


# Local flake on MacOS:
- Install Nix and Homebrew
- Clone the dotfiles repository
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
  
# Local flake on NixOS:
- Temporary run git:
  ```
  nix-shell -p git
  ```
- Clone the dotfiles repository
- Install the flake:
  ```
  sudo nixos-rebuild switch --impure --flake .#nixos
  ```
- To update your configuration, you can run:
  ```
  nix flake update && sudo nixos-rebuild switch --impure --flake .#nixos

 # To use another branch than main ( e. g. test ):
   ```
  darwin-rebuild switch --flake github:vpletea/dotfiles/test#macos
  ```
  ```
  sudo nixos-rebuild switch --impure --flake github:vpletea/dotfiles/test#nixos
  ```

