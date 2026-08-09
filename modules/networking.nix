{ config, lib, pkgs, user, host, ... }:

let
  cfg = config.features.networking;
in {
  options.features.networking = {
    enable = lib.mkEnableOption "Networking";
    allowedTCPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [ 8080 ];
    };
    allowedUDPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [];
    };
    tailscale = {
      enable = lib.mkEnableOption "Tailscale";
    };
  };
  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      networking.hostName = host;
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
      networking.networkmanager.enable = true;
      networking.firewall = {
        inherit (cfg) allowedTCPPorts allowedUDPPorts;
        # enable = false;
      };
      # networking.hosts = {
      #   "127.0.0.2" = ["other-localhost"];
      #   "192.0.2.1" = ["mail.example.com" "imap.example.com"];
      # };    
      users.users.${user} = {
        extraGroups = [ "networkmanager" ];
      };
    }
    (lib.mkIf cfg.tailscale.enable {
      services.tailscale.enable = true;
      networking.nftables.enable = true;
      networking.firewall = {
        trustedInterfaces = [ "tailscale0" ];
        allowedUDPPorts = [ config.services.tailscale.port ];
      };
      systemd.services.tailscaled.serviceConfig.Environment = [ 
        "TS_DEBUG_FIREWALL_MODE=nftables" 
      ];
      systemd.network.wait-online.enable = false; 
      boot.initrd.systemd.network.wait-online.enable = false;
    })
  ]);
}
