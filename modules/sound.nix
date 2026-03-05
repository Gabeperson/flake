{ config, lib, pkgs, ... }:

let
  cfg = config.features.sound;
in {
  options.features.sound = {
    enable = lib.mkEnableOption "Sound";
  };
  config = lib.mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
