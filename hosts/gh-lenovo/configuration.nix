# { config, pkgs, user, host, ... }:
{ ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules
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
  features.rust.enable = true;
  features.flameshot.enable = false;
  features.eyedropper.enable = false;
  features.firejail.enable = true;
  features.vm.enable = false;
  features.steam.enable = true;
  features.vscode.enable = true;
  features.foot.enable = true;
  features.r2modman.enable = true;

  features.niri.enable = true;
  features.ashell.enable = false;
  features.noctalia.enable = true;
  features.wayle.enable = false;
  features.vicinae.enable = true;
  features.hyprlock.enable = false;
  features.hypridle.enable = false;
  features.wezterm.enable = true;
  features.awww.enable = false;
  features.swaync.enable = true;

  features.wl-clipboard.enable = true;

  features.gamedev.enable = true;

  features.slack.enable = true;
  features.zoom.enable = true;
  features.obs.enable = true;
  features.libreoffice.enable = true;


  # Digicert root CA for Uni wifi
  environment.etc."custom-certs/DigiCert.crt" = {
    source = ./certs/DigiCertGlobalRootCA.crt;
  };

  # boot.kernelParams = [
  #   "pcie_aspm=off"
  #   "nvme_core.default_ps_max_latency_us=0"
  # ];

  # https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/issues/903#note_2619256
  # systemd.services.nvidia-suspend = {
  #   serviceConfig = {
  #     ExecStart = [ "" ''/run/current-system/sw/bin/bash -c 'echo "suspend" > /proc/driver/nvidia/suspend' '' ];
  #   };
  #   unitConfig = {
  #     ConditionPathExists="/proc/driver/nvidia/suspend";
  #   };
  # };
  # systemd.services.nvidia-resume = {
  #   serviceConfig = {
  #     ExecStart = [ "" ''/run/current-system/sw/bin/bash -c 'echo "resume" > /proc/driver/nvidia/suspend' ''];
  #   };
  #   unitConfig = {
  #     ConditionPathExists="/proc/driver/nvidia/suspend";
  #   };
  # };
}
