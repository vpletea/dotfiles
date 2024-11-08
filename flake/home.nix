{pkgs, ...}: let
  username = "vali.pletea";
  homeDirectory = "/Users/${username}";
in {
  users.users."${username}" = {
  home = homeDirectory;
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${username}" = {
      home = {
        inherit homeDirectory username;
        stateVersion = "23.11";
      };
    imports = [
	      ./starship.nix
        ./kitty.nix
      ];
    };
  };
  system.stateVersion = 4;
}