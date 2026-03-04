{ config, lib, pkgs, ... }:

let
  cfg = config.features.media;
in {
  options.features.media = {
    enable = lib.mkEnableOption "Media Tools/Apps";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vlc
      yt-dlp
      ffmpeg-full
    ];
  };
}
