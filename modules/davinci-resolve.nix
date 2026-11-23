
{config, lib, pkgs, user, ...}:

let
  cfg = config.features.davinci-resolve;
in {
  options.features.davinci-resolve = {
    enable = lib.mkEnableOption "davinci-resolve";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.davinci-resolve
    ];
  };
}

