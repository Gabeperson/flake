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
  options.features.ashell = {
    enable = lib.mkEnableOption "Noctalia";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdev.hostPlatform.system}.default
    ];
    home-manager.users.${user} = {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia = {
        enable = true;
      };
    };
  };
}
