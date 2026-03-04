{ config, lib, pkgs, ... }:

let
  cfg = config.features.swap;
in {
  options.features.swap = {
    enable = lib.mkEnableOption "Swap";
    size = lib.mkOption {
      type = lib.types.int;
      description = "Size of swapfile in MiB";
      default = 16*1024;
    };
  };

  config = lib.mkIf cfg.enable {
    swapDevices = [{
      device = "/swapfile";    
      size = cfg.size;
    }];
  };
}
