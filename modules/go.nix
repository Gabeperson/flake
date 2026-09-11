{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.features.go;
in
{
  options.features.go = {
    enable = lib.mkEnableOption "go";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.go_1_27
    ];
  };
}

