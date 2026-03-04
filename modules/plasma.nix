{ config, lib, pkgs, user, ... }:

let
  cfg = config.features.plasma;
  bibata = config.features.bibata;
  fcitx = config.features.fcitx;
in {
  options.features.plasma = {
    enable = lib.mkEnableOption "KDE Plasma";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    users.users.${user}.packages = [ pkgs.kdePackages.kate ];
    environment = {
      variables = {
        QT_QPA_PLATFORM="wayland";
      };
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
    };
    home-manager.users.${user} = {
      programs.plasma = {
        enable = true;
        workspace = {
          lookAndFeel = "org.kde.breezedark.desktop";
        } // (lib.mkIf bibata.enable {
          cursor.theme = "Bibata-Modern-Ice";
        });
        configFile = {
          kdeglobals.KDE.AnimationDurationFactor = 0.5;

          kwinrc.TabBox.HighlightWindows = false;
          kwinrc.TabBox.DelayTime = 5;
          kwinrc.Effect-blur.BlueStrength = 9;
          kwinrc.Plugins.blurEnabled = true;

          plasmaparc.General.AudioFeedback = false;
        } // (lib.mkIf fcitx.enable {
          kwinrc.Wayland."InputMethod[$e]" = "/run/current-system/sw/share/applications/org.fcitx.Fcitx5.desktop";
        });
      };
      home.file.".local/share/konsole/hazel.colorscheme" = {
        source = ../data/hazel.colorscheme;
      };
      programs.konsole = {
        enable = true;
        defaultProfile = "Hazel";
        profiles = {
          hazel = {
            colorScheme = "hazel";
            name = "Hazel";
            font = {
              # name = "Hack";
              size = 12;
            };
          };
        };
      };
    };
  };
}

