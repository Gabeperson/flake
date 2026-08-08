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
              "cpu"
              "ram"
              "temp"
              "workspaces"
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
        };
      };
    };
  };
}
