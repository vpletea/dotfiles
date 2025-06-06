# Flake installation
### MacOS
- Install Nix from: https://nixos.org/download/#nix-install-macos
- Install Homebrew from:  https://brew.sh/
- Run git:
  ```
    nix-shell -p git
  ```
- Clone the repo and switch to macos directory:
  ```
    git clone https://github.com/vpletea/dotfiles.git
    cd dotfiles/macos
  ```
- Install the flake:
  ```
  sudo nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#macos
  ```
- After the first run we can use:
  ```
  sudo darwin-rebuild switch --flake .#macos
  ```
- Note on ssh_sk keys:
    - Import the key using ``` ssh-keygen -K ```
    - Add the imported key or keys via zshrc using a similar line ``` ssh-add -q ~/.ssh/id_ed25519_sk_rk_Yubikey-USB-C ```


### NixOS
- Install Nixos with Gnome Desktop from https://nixos.org/download/#nix-install-linux
- Run git:
  ```
    nix-shell -p git
  ```
- Clone the repo and switch to nixos directory:
  ```
    git clone https://github.com/vpletea/dotfiles.git
    cd dotfiles/nixos
  ```
- Install the flake:
  ```
  sudo nixos-rebuild switch --impure --flake .#nixos
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
  darwin-rebuild switch --flake .#macos
  ```
  ```
  sudo nixos-rebuild switch --impure --flake .#nixos
  ```

###
- Sample devbox.json file:
  ```
   {
      "$schema": "https://raw.githubusercontent.com/jetify-com/devbox/0.14.2/.schema/devbox.schema.json",
      "packages": ["k3d", "terraform", "kubectl", "kubernetes-helm"],
   }
   ```
- Place this in your git folder project and run ``` devbox shell ```