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
          "0" = "Alt+Alt_R"; 
        };
      };
    };
  };
}
