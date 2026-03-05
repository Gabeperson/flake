{ config, pkgs, user, host, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./modules
    ];

  features.bibata.enable = true;
  features.bluetooth.enable = true;
  features.bootloader = "grub";
  features.chromium.enable = true;
  features.cli-tools.enable = true;
  features.fcitx.enable = true;
  features.firefox.enable = true;
  features.helix.enable = true;
  features.librewolf.enable = true;
  features.media.enable = true;
  features.nvidia.enable = true;
  features.plasma.enable = false;
  features.printing.enable = true;
  features.swap.enable = true;
  features.sound.enable = true;
  features.networking.enable = true;
  features.networking.tailscale.enable = true;
  features.vesktop.enable = true;
  features.zellij.enable = true;
  features.java.enable = true;
  features.minecraft.enable = true;
  features.fish.enable = true;
  features.gnome.enable = true;
}
