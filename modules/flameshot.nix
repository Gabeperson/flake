{ config, pkgs, lib, user, ... }:
let
  cfg = config.features.flameshot;
  flameshot-script = pkgs.writeShellScriptBin "flameshot-gui" "${pkgs.flameshot}/bin/flameshot gui";
in
{
  options.features.flameshot = {
    enable = lib.mkEnableOption "Flameshot";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      flameshot
      grim
    ];
    home-manager.users.${user} = {
      services.flameshot = {
        # Also installs/enables flameshot
        enable = true;
        settings = {
          General = {
            useGrimAdapter = true;
            # Stops warnings for using Grim
            disabledGrimWarning = true;
            disabledTrayIcon = true;
            showDesktopNotification = false;
            showAbortNotification = false;
            showHelp = false;
          };
        };
      };
      dconf.settings = lib.mkIf config.features.gnome.enable {
        # Disable old screenshot
        "org/gnome/shell/keybindings" = {
          show-screenshot-ui = [ ];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Shift><Super>s";
          command = "${flameshot-script}/bin/flameshot-gui";
          name = "Flameshot";
        };
      };
    };
  };
}
