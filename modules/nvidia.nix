{ config, lib, pkgs, ... }:

let
  cfg = config.features.nvidia;
in {
  options.features.nvidia = {
    enable = lib.mkEnableOption "Nvidia";
    intelBusId = lib.mkOption {
      type = nullOr lib.types.str;
      default = "PCI:0@0:2:0";
    };
    nvidiaBusId = lib.mkOption {
      type = nullOr lib.types.str;
      default = "PCI:1@0:0:0";
    };
    amdBusId = lib.mkOption {
      type = nullOr lib.types.str;
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.open = false;
    hardware.nvidia.prime = {
      reverseSync.enable = true;
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };
}
