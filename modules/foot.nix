{ config, lib, user, ... }:
let
  cfg = config.features.foot;
in {
  options.features.foot = {
    enable = lib.mkEnableOption "Foot";
  };

  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
    };
    home-manager.users.${user} = {
      programs.foot = {
        enable = true;
        settings = {
          main = {
            font = "monospace:size=12";
          };
        };
      };
    };
  };
}


