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
      programs.wayle = {
        enable = true;
        autoInstallDependencies = true;
        settings = {
          
        };
      };
    };
  };
}


