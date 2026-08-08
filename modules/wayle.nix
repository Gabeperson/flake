{
  config,
  pkgs,
  lib,
  user,
  inputs,
  ...
}:
let
  cfg = config.features.wayle;
in
{
  options.features.wayle = {
    enable = lib.mkEnableOption "Wayle";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${user} = {
      services.wayle = {
        enable = true;
        autoInstallDependencies = true;
        settings = {
          
        };
      };
    };
  };
}


