{
  config,
  lib,
  pkgs,
  user,
  inputs,
  ...
}:
let
  cfg = config.features.kdenlive;
in
{
  options.features.kdenlive = {
    enable = lib.mkEnableOption "Kdenlive";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.kdePackages.kdenlive
    ];

  };
}
