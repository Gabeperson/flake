{
  config,
  pkgs,
  lib,
  user,
  ...
}:
let
  cfg = config.features.niri;
in
{
  options.features.niri = {
    enable = lib.mkEnableOption "Niri";
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
    environment.systemPackages = [
      pkgs.xwayland-satellite
      pkgs.kdePackages.polkit-kde-agent-1
    ];
    home-manager.users.${user} = {
      home.file.".config/niri/config.kdl" = {
        source = ../config/niri.kdl;
      };
      home.packages = [
        pkgs.kdePackages.polkit-kde-agent-1
      ];
      systemd.user.services.kde-polkit-agent = {
        Unit = {
          Description = "KDE polkit";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
          Requisite = [ "graphical-session.target" ];
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
        Service = {
          ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
          Restart = "on-failure";
        };
      };
    };
  };
}
