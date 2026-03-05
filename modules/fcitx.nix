{config, lib, pkgs, ...}:

let
  cfg = config.features.fcitx;
in {
  options.features.fcitx = {
    enable = lib.mkEnableOption "Fcitx (Korean support)";
  };
  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = [pkgs.fcitx5-hangul];
      fcitx5.settings.globalOptions = {
        "Hotkey/TriggerKeys" = {
          "0" = "Alt_R"; 
        };

        "Hotkey/AltTriggerKeys" = {
          "0" = "Alt_R";
        };
      };
      fcitx5.settings.inputMethod = {
        "GroupOrder"."0" = "Default";
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "hangul";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "hangul";
      };
    };
  };
}
