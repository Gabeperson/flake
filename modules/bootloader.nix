{ config, lib, pkgs, ... }:

let
  cfg = config.features;
in {
  options.features.bootloader = lib.mkOption {
    type = lib.types.enum [ "systemd-boot" "grub" ];
    default = "systemd-boot";
    description = "Which bootloader to use";
  };
  config = lib.mkMerge [
    {
      boot.loader.efi.efiSysMountPoint = "/boot";
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.timeout = 30;
    }
    (lib.mkIf (cfg.bootloader == "systemd-boot") {
      boot.loader.systemd-boot.enable = true;
    })
    (lib.mkIf (cfg.bootloader == "grub") {
      boot.loader = {
        timeout = 30;
        grub = {
          enable = true;
          useOSProber = true;
          efiSupport = true;
          # efiInstallAsRemovable = true;
          devices = [ "nodev" ];
          extraEntries = ''
            menuentry "Reboot" {
              reboot
            }
            menuentry "Shutdown" {
              halt
            }
            menuentry "UEFI/BIOS Settings" {
              fwsetup
            }
          '';
        };
      };
    })
  ];
}
