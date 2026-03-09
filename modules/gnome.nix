{config, pkgs, lib, user, host, ...}:
let
  cfg = config.features.gnome;
in {
  options.features.gnome = {
    enable = lib.mkEnableOption "Gnome";        
  };
  config = lib.mkIf cfg.enable {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.gnome.games.enable = false;
    environment.systemPackages = [
      pkgs.gnomeExtensions.blur-my-shell
      pkgs.gnomeExtensions.wallpaper-slideshow
      pkgs.gnomeExtensions.dash-to-panel
      pkgs.gnomeExtensions.arcmenu

      pkgs.morewaita-icon-theme
    ];
    environment.gnome.excludePackages = [
      pkgs.gnome-tour
      pkgs.simple-scan
      pkgs.gnome-connections
      pkgs.gnome-contacts
      pkgs.epiphany
    ];
    
    environment = {
      variables = {
        # QT_QPA_PLATFORM="wayland";
        # XMODIFIERS="@im=fcitx";
        # QT_IM_MODULE="fcitx5";
        # QT_IM_MODULES="wayland;fcitx";
      };
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
    };
    home-manager.users.${user} = { lib, pkgs, ... }: {
      dconf.enable = true;
      dconf.settings = {
        "org/gnome/shell" = {
          enabled-extensions = [
            pkgs.gnomeExtensions.blur-my-shell.extensionUuid
            # pkgs.gnomeExtensions.wallpaper-slideshow.extensionUuid
            # pkgs.gnomeExtensions.dash-to-panel.extensionUuid
            # pkgs.gnomeExtensions.arcmenu.extensionUuid
          ];
        };
        "org/gnome/desktop/wm/keybindings" = {
          switch-applications = [];
          switch-applications-backward = [];
          switch-windows = ["<Alt>Tab"];
          switch-windows-backward = ["<Shift><Alt>Tab"];
        };
        "org/gnome/desktop/interface" = {
          icon-theme = "MoreWaita";
        };
        # "org/gnome/desktop/screensaver" = {
        #   lock-delay = lib.hm.gvariant.mkUint32 1;
        # };
      };
    };
  };
}
