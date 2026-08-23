{
  config,
  pkgs,
  lib,
  user,
  inputs,
  ...
}:
let
  cfg = config.features.noctalia;
in
{
  options.features.noctalia = {
    enable = lib.mkEnableOption "Noctalia";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    home-manager.users.${user} = {
      home.file.".config/noctalia/palettes/CatpuccinMacchiatoPinkMod.json" = {
        source = ../config/CatppuccinMacchiatoPinkMod.json;
      };
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia = {
        enable = true;
        systemd.enable = true;
        settings = {
          osd.kinds.media = false;
          shell = {
            launch_apps_as_systemd_services = true;
          };
          widget.clock = {
            format = "{:%a, %b %-d, %Y, %I:%M:%S %P}";
          };
          bar.default = {
            margin_ends = 0;
            concave_edge_corners = false;
            start = [
              "wallpaper"
              "workspaces"
              "cpu"
              "ram"
              "temp"
            ];
            center = [ "clock" ];
            end = [
              "media"
              "tray"
              "notifications"
              "clipboard"
              "network"
              "bluetooth"
              "volume"
              "brightness"
              "battery"
              "control-center"
              "session"
            ];
          };
          wallpaper = {
            directory_dark = "/home/${user}/Wallpapers/backstage";
            directory_light = "/home/${user}/Wallpapers/stage";
            # automation = {
            #   enabled = true;
            #   interval_seconds = 1800;
            #   order = "random";
            #   recursive = "true";
            # };
            transition = [];
          };
          idle = {
            pre_action_fade_seconds = 30.0;
            behavior_order = [
              "lock"
              "screen-off"
              "suspend"
            ];
            behavior = {
              lock = {
                timeout = 600;
                action = "lock";
                enabled = true;
              };
              screen-of = {
                timeout = 660;
                action = "screen_off";
                enabled = true;
              };
              suspend = {
                timeout = 900;
                action = "lock_and_suspend";
              };
            };
          };
          theme = {
            source = "custom";
            custom_palette = "CatppuccinMacchiatoPinkMod";
          };
        };
      };
    };
  };
}
