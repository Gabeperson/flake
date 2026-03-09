{ config, lib, pkgs, user, inputs, ... }:
let
  cfg = config.features.awww;
in {
  options.features.awww = {
    enable = lib.mkEnableOption "Awww";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    ];
    home-manager.users.${user} = {
      services.swww = {
        enable = true;
        package = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;

      };
    };
  };
}

