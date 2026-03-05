{ config, lib, pkgs, user, ... }:
let
  cfg = config.features.minecraft;
in {
  options.features.minecraft = {
    enable = lib.mkEnableOption "Minecraft";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${user} = {
      home.packages = [ pkgs.prismlauncher ];
    };
  };
}
