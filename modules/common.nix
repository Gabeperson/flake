{ pkgs, user, ... }:
{
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

  fonts.packages = [
    pkgs.noto-fonts-cjk-sans
    pkgs.nerd-fonts.fira-code
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Noto Sans" ];
      monospace = [ "FiraCode Nerd Font" ];
    };
  };

  environment.systemPackages = [
    pkgs.lm_sensors
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  services.gnome.gnome-keyring.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "password";
  };

  security.polkit.enable = true;
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

        };
      }
    ];
  };

  nix = {
    settings.auto-optimise-store = true;
  };
  # programs.gnupg.agent = {
  #   enable = true;
  #   # enableSSHSupport = true;
  # };
  system.stateVersion = "25.11";
}
