{
  config,
  pkgs,
  lib,
  user,
  ...
}:
let
  cfg = config.features.ashell;
in
{
  options.features.ashell = {
    enable = lib.mkEnableOption "ashell bar";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.ashell
    ];
    home-manager.users.${user} = {
      programs.ashell = {
        enable = true;
        systemd.enable = true;
        settings = {
          modules = {
            left = [
              "Workspaces"
              "Privacy"
            ];
            center = [
              "WindowTitle"
              "MediaPlayer"
            ];
            right = [
              "SystemInfo"
              "Clock"
              "Tray"
              "Settings"
            ];
          };
          clock = {
            format = "%A, %b %d %r";
          };
          system_info = {
            indicators = [
              "DownloadSpeed"
              "UploadSpeed"
              "IpAddress"
              "Cpu"
              "Memory"
              "Temperature"
            ];
            cpu = {
              warn_threshold = 60;
              alert_threshold = 80;
            };
            memory = {
              warn_threshold = 70;
              alert_threshold = 85;
            };
            disk = {
              warn_threshold = 80;
              alert_threshold = 90;
            };
            temperature = {
              warn_threshold = 70;
              alert_threshold = 80;
              sensor = "coretemp Package id 0";
            };
          };
        };
      };
    };
  };
}
