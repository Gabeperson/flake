{
  config,
  pkgs,
  lib,
  user,
  ...
}:
let
  cfg = config.features.hyprlock;
in
{
  options.features.hyprlock = {
    enable = lib.mkEnableOption "Hyprlock";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprlock.enable = true;

    home-manager.users.${user} = {
      programs.hyprlock = {
        enable = true;
        settings = {
          general = {
            hide_cursor = true;
            ignore_empty_input = true;
            # immediate_render = true;
            grace = 30;
          };
          background = [
            {
              monitor = "";
              path = "screenshot";
              blur_passes = 4;
              blur_size = 10;
            }
          ];
          input-field = [
            {
              size = "300, 50";
              position = "0, -3%";
              halign = "center";
              valign = "center";
              monitor = "";
              dots_center = true;
              fade_on_empty = false;
              font_color = "rgb(100, 160, 150)";
              outer_color = "rbga(50, 250, 150, 0.3)";
              inner_color = "rgba(50, 50, 50, 0.3)";
              outline_thickness = 3;
              placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
              shadow_passes = 3;
            }
          ];
          label = [
            {
              # time
              monitor = "";
              text = "$TIME12";
              color = "rgb(60, 150, 135)";
              font_size = 90;
              position = "0, 400";
              halign = "center";
              valign = "center";
            }
            {
              # username
              monitor = "";
              # 
              text = "Hello, $USER";
              color = "rgba(255, 255, 255, 0.8)";
              position = "0, 3%";
              font-size = 30;
              halign="center";
              valign="center";
            }
          ];
        };
      };
    };
  };

}
