{ config, lib, pkgs, user, ... }:

let
  cfg = config.features.ssh;
in {
  options.features.ssh = {
    enable = lib.mkEnableOption "SSH";
    ports = lib.mkOption {
      type = lib.types.listOf lib.types.int;
    };
    allowedUsers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ user ];
    };
    fail2ban = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services.openssh = {
        enable = true;
        inherit (cfg) ports;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
          inherit (cfg) allowedUsers;
        };
      };
    })
    (lib.mkIf cfg.fail2ban {
      services.fail2ban.enable = true; 
    })
  ];
}

