{
  config,
  lib,
  pkgs,
  user,
  inputs,
  ...
}:
let
  cfg = config.features.swaylock;
in
{
  options.features.swaylock = {
    enable = lib.mkEnableOption "swaylock";
  };

  config = lib.mkIf cfg.enable {
    security.pam.services.swaylock = { };
    environment.systemPackages = [
      pkgs.libnotify
    ];
    home-manager.users.${user} = {
      programs.swaylock = {
        enable = true;
        settings = {
          color = "130133";
          font-size = 24;
          indicator-idle-visible = true;
          show-failed-attempts = true;
        };
      };
      services.swayidle =
        let
          screenoff = "${pkgs.niri}/bin/niri msg action power-off-monitors";
          screenon = "${pkgs.niri}/bin/niri msg action power-on-monitors";
          suspend = "${pkgs.systemd}/bin/systemctl suspend";
          notify =
            time:
            "${pkgs.libnotify}/bin/notify-send 'Locking in ${builtins.toString time} seconds' -t ${
              builtins.toString (time * 1000)
            }";
          lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
        in
        {
          enable = true;
          timeouts = [
            {
              timeout = 540;
              command = notify 60;
            }
            {
              timeout = 600;
              command = lock;
            }
            {
              timeout = 720;
              command = screenoff;
              resumeCommand = screenon;
            }
            {
              timeout = 900;
              command = suspend;
            }
          ];
          events = {
            "before-sleep" = lock;
            "lock" = lock;
            "after-resume" = screenon;
          };
        };
    };
  };
}
