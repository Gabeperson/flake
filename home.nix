{ config, lib, pkgs, user, host, self, ...}:

{
  home.username = user;  
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.11";


  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Bibata-Modern-Ice";
      };
    };
    configFile = {
      kdeglobals.KDE.AnimationDurationFactor = 0.5;

      kwinrc.TabBox.HighlightWindows = false;
      kwinrc.TabBox.DelayTime = 5;
      kwinrc.Effect-blur.BlueStrength = 9;
      kwinrc.Plugins.blurEnabled = true;
      kwinrc.Wayland."InputMethod[$e]" = "/run/current-system/sw/share/applications/org.fcitx.Fcitx5.desktop";

      plasmaparc.General.AudioFeedback = false;
    };
  };

  
  home.file.".local/share/konsole/hazel.colorscheme" = {
    source = ./data/hazel.colorscheme;
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
}
