{
  description = "Home Manager configuration of vali.pletea";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {  self, nixpkgs, nix-darwin, home-manager, ...  }:
  {
      darwinConfigurations."Valis-iMac-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        {
          nixpkgs.hostPlatform = "x86_64-darwin";
          nix.settings.experimental-features = "nix-command flakes";
          # Set your time zone.
          time.timeZone = "Europe/Bucharest";
          nixpkgs.config.allowUnfree = true;
          environment.pathsToLink = [ "/share/zsh" ];
          users.users."vali.pletea" = {
            name = "vali.pletea";
            home = "/Users/vali.pletea";
          };
          home-manager.backupFileExtension = "backup";
          # nix.configureBuildUsers = true;
          # nix.useDaemon = true;
          system.configurationRevision = self.rev or self.dirtyRev or null;  # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;
          # nix.package = pkgs.nix;
          security.pam.enableSudoTouchIdAuth = true;
          # Create /etc/zshrc that loads the nix-darwin environment.
          programs.zsh.enable = true;

          # Used for backwards compatibility, please read the changelog before changing.
          system.stateVersion = 4;
        }
        ./modules/macos-config.nix
        ./modules/aliases.nix
				home-manager.darwinModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users."vali.pletea" = import ./modules/macos-home.nix;
				}
        ];
      };

      # homeConfigurations."vali.pletea" = home-manager.lib.homeManagerConfiguration {
      # pkgs = nixpkgs.legacyPackages."x86_64-darwin";
      #   # Specify your home configuration modules here, for example,
      #   # the path to your home.nix.
      #   modules = [ ./modules/macos-home.nix ];
      # };
    };
}
