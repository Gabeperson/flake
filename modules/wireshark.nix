{
  config,
  pkgs,
  lib,
  user,
  ...
}:
let
  cfg = config.features.wireshark;
in
{
  options.features.wireshark = {
    enable = lib.mkEnableOption "wireshark";
  };

  config = lib.mkIf cfg.enable {
    programs.wireshark.enable = true;
    programs.wireshark.package = pkgs.wireshark;
    users.users.${user} = {
      extraGroups = ["wireshark"];
    };
  };
}

