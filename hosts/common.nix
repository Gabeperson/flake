{inputs, user, host, pkgs, ...}:
{
  inputs.home-manager.nixosModules.home-manager = {
    # home-manager.extraSpecialArgs = specialArgs;
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    # home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
    home-manager.users.${user} = {
      home.username = user;  
      home.homeDirectory = "/home/${user}";
      home.stateVersion = "25.11";
    };
    home-manager.backupFileExtension = "hmbackup";
  };
}
