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
  };
}
