{ config, pkgs, lib, user, ... }:
let
  cfg = config.features.vm;
in {
  options.features.vm = {
    enable = lib.mkEnableOption "vm"; 
  };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
      qemu.package = pkgs.qemu;
    };
    programs.virt-manager.enable = true;
    environment.systemPackages = with pkgs; [
      dnsmasq
    ];
    networking.firewall.trustedInterfaces = [ "virbr0" ];
    users.users.${user}.extraGroups = [
      "libvirtd"
    ];
  };
}


