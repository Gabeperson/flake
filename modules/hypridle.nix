{ config, pkgs, lib, user, ... }:
let
  cfg = config.features.hypridle;
in {
  options.features.hypridle = {
    enable = lib.mkEnableOption "Hypridle"; 
  };

  config = lib.mkIf cfg.enable {
    services.hypridle.enable = true;
    home-manager.users.${user} = {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "pidof hyprlock || hyprlock";
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "niri msg action power-on-monitors";
          };
          listener = [
            {
              timeout = 300;
              on-timeout = "brightnessctl -s set 10";
              on-resume = "brightnessctl -r";
            }
            {
              timeout = 600;
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = 660;
              on-timeout = "niri msg action power-off-monitors";
              on-resume = "niri msg action power-on-monitors && brightnessctl -r";
            }
            {
              timeout = 1800;
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };
    };
  };
}


