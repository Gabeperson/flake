{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  cfg = config.features.minecraft;
in
{
  options.features.minecraft = {
    enable = lib.mkEnableOption "Minecraft";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.prismlauncher.override {
        additionalLibs = [
          pkgs.libxtst
          pkgs.libxt
          pkgs.libxt
          pkgs.libxinerama
          pkgs.libx11.dev
          pkgs.libxcb
          pkgs.libxkbcommon
        ];
      })
      # pkgs.prismlauncher
      pkgs.waywall
      pkgs.ninjabrain-bot
    ];
  };
}
