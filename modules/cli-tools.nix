{ config, lib, pkgs, ... }:

let
  cfg = config.features.cli-tools;
in {
  options.features.cli-tools = {
    enable = lib.mkEnableOption "Cli Tools";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      steam-run
      dust
      ripgrep
      just
      zoxide
      hexyl
      fd
      kondo
      wget
    ];
  };
}
