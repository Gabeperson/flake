{
  config,
  pkgs,
  lib,
  user,
  inputs,
  ...
}:
let
  cfg = config.features.noctalia;
in
{
  options.features.noctalia = {
    enable = lib.mkEnableOption "Noctalia";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    home-manager.users.${user} = {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia = {
        enable = true;
        systemd.enable = true;
        settings = {
          shell = {
            launch_apps_as_systemd_services = true;
          };
        };
      };
    };
  };
}
