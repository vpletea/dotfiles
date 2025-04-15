# Flake installation
### MacOS
- Install Nix using Lix installer: https://lix.systems/install/
- Install Homebrew from:  https://brew.sh/
- Run git:
  ```
    nix-shell -p git
  ```
-
    git clone https://github.com/vpletea/dotfiles.git
    cd dotfiles/macos
  ```
- Install the flake:
  ```
  nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ".#aarch64"
  ```
- After the first run we can use:
  ```
  darwin-rebuild switch --flake ".#aarch64"
  ```

### NixOS
- Clone the repository:
  ```
    nix-shell -p git
    git clone https://github.com/vpletea/dotfiles.git
    cd dotfiles/nixos
  ```
- Install the flake:
  ```
  sudo nixos-rebuild switch --impure --flake ".#x86_64"
- Remove the nixos channel:
  ```
  sudo nix-channel --remove nixos
  ```
- Backup configuration.nix:
  ```
  sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.backup
  ```

### Updates
- To update the flake go to your OS directory and run the following command:
  ```
  nix flake update
  ```
- Run the install flake command depending on your OS:
  ```
  nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ".#aarch64"
  ```
  ```
  sudo nixos-rebuild switch --impure --flake ".#x86_64"
  ```
