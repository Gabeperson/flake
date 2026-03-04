{ config, pkgs, user, host, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/bibata.nix
      ./modules/bluetooth.nix
      ./modules/bootloader.nix
      ./modules/chromium.nix
      ./modules/cli-tools.nix
      ./modules/fcitx.nix
      ./modules/firefox.nix
      ./modules/helix.nix
      ./modules/librewolf.nix
      ./modules/media.nix
      ./modules/nvidia.nix
      ./modules/plasma.nix
      ./modules/printing.nix
      ./modules/swap.nix
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
  features.plasma.enable = true;
  features.printing.enable = true;
  features.swap.enable = true;

  networking.hostName = host; # Define your hostname.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Enable networking
  networking.networkmanager.enable = true;
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_CA.UTF-8";
    LC_IDENTIFICATION = "en_CA.UTF-8";
    LC_MEASUREMENT = "en_CA.UTF-8";
    LC_MONETARY = "en_CA.UTF-8";
    LC_NAME = "en_CA.UTF-8";
    LC_NUMERIC = "en_CA.UTF-8";
    LC_PAPER = "en_CA.UTF-8";
    LC_TELEPHONE = "en_CA.UTF-8";
    LC_TIME = "en_CA.UTF-8";
  };


  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;


  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "password";
  };


  environment.variables = {
    QT_QPA_PLATFORM="wayland";
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nix = {
    settings.auto-optimise-store = true;
  };
  # programs.gnupg.agent = {
  #   enable = true;
  #   # enableSSHSupport = true;
  # };

  # services.openssh.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  system.stateVersion = "25.11";
}
