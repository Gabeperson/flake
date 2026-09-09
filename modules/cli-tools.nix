{ config, lib, pkgs, ... }:

let
  cfg = config.features.cli-tools;
in {
  options.features.cli-tools = {
    enable = lib.mkEnableOption "Cli Tools";
  };

  config = lib.mkIf cfg.enable {
    programs.git.enable = true;
    programs.zoxide.enable = true;
    programs.yazi.enable = true;
    environment.systemPackages = with pkgs; [
      steam-run
      dust
      ripgrep
      just
      hexyl
      fd
      kondo
      wget
      gh
      p7zip
      gnumake
      valgrind
      htop
      btop-cuda
      watchexec
      brightnessctl
    ];
  };
}
