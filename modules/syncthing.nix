{
  config,
  lib,
  pkgs,
  user,
  inputs,
  ...
}:
let
  cfg = config.features.syncthing;
in
{
  options.features.syncthing = {
    enable = lib.mkEnableOption "Syncthing";
  };

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      settings = {
        devices = {
          
        };
      };
    };
  };
}
