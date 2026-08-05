{ config, lib, pkgs, user, inputs, ... }:
let
  cfg = config.features.gamedev;
in {
  options.features.gamedev = {
    enable = lib.mkEnableOption "Gamedev";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.godot_4_7
      pkgs.aseprite
    ];
  };
}

