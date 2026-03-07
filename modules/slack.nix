{ config, lib, pkgs, user, ... }:

let
  cfg = config.features.slack;
in {
  options.features.slack = {
    enable = lib.mkEnableOption "Slack";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.slack
    ];
  };
}
