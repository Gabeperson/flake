{
  config,
  pkgs,
  lib,
  user,
  ...
}:
let
  cfg = config.features.meld;
in
{
  options.features.meld = {
    enable = lib.mkEnableOption "meld";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.meld
    ];
  };
}

