{ config, lib, pkgs, ... }:

let
  cfg = config.features.nvidia;
in {
  options.features.nvidia = {
    enable = lib.mkEnableOption "Nvidia";
    intelBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:0@0:2:0";
    };
    nvidiaBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:1@0:0:0";
    };
    amdgpuBusId = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services."systemd-suspend" = {
      serviceConfig = {
        Environment = ''"SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false"'';
      };
    };
    hardware.graphics.enable = true;
    hardware.graphics = {
      extraPackages = [
        pkgs.nvidia-vaapi-driver
      ];
    };
    hardware.nvidia.powerManagement.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.open = false;
    hardware.nvidia.prime = {
      inherit (cfg) intelBusId nvidiaBusId amdgpuBusId;
      reverseSync.enable = true;
    };
  };
}
