{ config, pkgs, lib, user, ... }:
let
  cfg = config.features.eyedropper;
in
{
  options.features.eyedropper = {
    enable = lib.mkEnableOption "Eyedropper";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      eyedropper
    ];
  };
}

