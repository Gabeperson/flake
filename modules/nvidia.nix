{ config, lib, pkgs, ... }:

let
  cfg = config.features.nvidia;
in {
  options.features.nvidia = {
    enable = lib.mkEnableOption "Nvidia";
    intelBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:0:2:0";
    };
    nvidiaBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:1:0:0";
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
      enable32Bit = true;
      extraPackages = [
        pkgs.nvidia-vaapi-driver
      ];
    };
    hardware.nvidia.powerManagement.enable = true;
    # hardware.nvidia.powerManagement.enable = false;
    hardware.nvidia.powerManagement.finegrained = false;
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      open = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      # prime = {
      #   inherit (cfg) intelBusId nvidiaBusId amdgpuBusId;
      #   # sync.enable = true;
      #   offload = {
      #     enable = true;
      #     enableOffloadCmd = true;
      #   };
      #   reverseSync.enable = false;
      # };
    };
  };
}
