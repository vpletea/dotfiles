# Flake installation

### MacOS
- Install Nix:
  ```
  curl -sSf -L https://install.lix.systems/lix | sh -s -- install
  ```
- Install Homebrew:
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
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
- Notes:
  - mkdir fails with 'Operation not permitted':
      - add nix to the "allow full disk access" security list
  - sudo nix complains about $HOME not being owned by your user
     - cand be ignored for most tasks for other like gc we can use sudo -i 

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

### Mise
- For temporary dev environments i use mise ( https://mise.jdx.dev/ ). Sample .mise.toml file below. Note that for ansible you have to add python and pipx in that file:
  ```
  [tools]
  "terraform" = "1.12.1"
  "kubectx" = "latest"
  "kubectl" = "latest"
  "ansible" = "latest"
  "python" = "latest"
  "pipx" = "latest"
   ```
- Place this in your git folder project and run ``` mise install ```

### SSH keys - i'm using ssh-keys backed by yubikeys
- ssh agent:
    - Import the key using ``` ssh-keygen -K ```
    - Add the imported key or keys via zshrc using a similar line ``` ssh-add -q ~/.ssh/id_ed25519_sk_rk_Yubikey-USB-C ```
- remote server:
    - read the public key:
      ```
      cat id_ed25519_sk_rk_Yubikey-USB-C.pub
      sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAILQwflbQ5CDJhaGSigNSrq0CmZbL82cdtBY2nylJAM9ZAAAAEXNzaDpZdWJpa2V5LVVTQi1D ssh:Yubikey-USB-C
      ```
    - prepare the key by replacing the "ssh:Yubikey-USB-C" with user@server:
      ```
      cat .ssh/authorized_keys 
      sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAILQwflbQ5CDJhaGSigNSrq0CmZbL82cdtBY2nylJAM9ZAAAAEXNzaDpZdWJpa2V5LVVTQi1D devops@gcp
      ```

