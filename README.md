# Multi OS dotfiles and configurations

# NixOS 
### Machine settings
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
- To update the flake run the following command:
  ```
  nix flake update
  ```
### Dotfiles setup
- Run chezmoi init:
  ```
  chezmoi init https://github.com/vpletea/dotfiles.git
  ```
- Apply the configuration:
  ```
  chezmoi apply
  ```

# MacOS
### Machine settings
- Enable Touch ID for sudo
  ```
  cd /etc/pam.d
  sudo cp sudo_local.template sudo_local
  sudo pico sudo_local
  ```
- Uncomment the line that contains pam_tid.so
- Install Homebrew:
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- Install chezmoi:
  ```
  brew install chezmoi
  ```
### Dotfiles setup
- Run chezmoi init:
  ```
  chezmoi init https://github.com/vpletea/dotfiles.git
  ```
- Apply the configuration:
  ```
  chezmoi apply
  ```


# Mise
- For project related tooling i use mise ( https://mise.jdx.dev/ ). Sample .mise.toml file below:
  ```
  [tools]
  "terraform" = "1.12.1"
  "kubectx" = "latest"
  "kubectl" = "latest"
  "ansible" = "latest"
  "python" = "latest"
  "pipx" = "latest"
   ```
- Place this in your git folder project and run ``` mise install -a ```

# SSH keys
### SSH keys backed by yubikey
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

