{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.libreoffice;
in
{
  options.features.libreoffice = {
    enable = lib.mkEnableOption "Libreoffice";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.libreoffice
    ];
  };
}
