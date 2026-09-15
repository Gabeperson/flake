{
  config,
  pkgs,
  lib,
  user,
  ...
}:
let
  cfg = config.features.cpp;
in
{
  options.features.cpp = {
    enable = lib.mkEnableOption "cpp";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gcc
      clang
      clang-tools
      gnumake
      cmake
    ];
  };
}

