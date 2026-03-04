{ config, pkgs, user, host, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.

  boot.loader = {
    timeout = 30;

    efi = {
      efiSysMountPoint = "/boot";
    };

    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
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

  networking.hostName = host; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
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

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [pkgs.fcitx5-hangul];
  }

  # # Enable the X11 windowing system.
  # # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # services.xserver.excludePackages = [
  #   pkgs.xterm
  # ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;
  hardware.nvidia.prime = {
    reverseSync.enable = true;
    intelBusId = "PCI:0@0:2:0";
    nvidiaBusId = "PCI:1@0:0:0";
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable CUPS to print documents.
  services.printing.enable = true;

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
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
    helix
    vesktop
    steam-run
    bibata-cursors
  ];

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
    QT_QPA_PLATFORM=wayland;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1"

  nix = {
    settings.auto-optimise-store = true;
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 7d";
    # };
  };
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # services.openssh.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
