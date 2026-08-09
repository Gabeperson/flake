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
      inherit user;
      dataDir = "/home/${user}";
      enable = true;
      openDefaultPorts = true;
      settings = {
        devices = {
          "gh-lenovo" = {
            id = "KMKROEW-FX2QIPA-CNJ3ZHW-Q7NTFGK-A5QRGMM-NI4KDHW-CO7QRHI-A63WGAE";
          };
        };
        folders = {
          "Wallpapers" = {
            path = "/home/${user}/Wallpapers";
            devices = [];
          };
        };
      };
    };
  };
}
