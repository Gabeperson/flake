{ config, lib, pkgs, user, ... }:

let
  cfg = config.features.firejail;
in {
  options.features.firejail = {
    enable = lib.mkEnableOption "firejail";
  };

  config = lib.mkIf cfg.enable {
    programs.firejail.enable = true;
    home-manager.users.${user} = {
      programs.fish = {
        functions = {
          jail = {
            body = ''
              mkdir -p "$PWD/firejail_sandbox"
              firejail --net=none --private="$PWD/firejail_sandbox" \
              --private-dev --noblacklist=/dev/dri --noblacklist="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" \
              --env="WAYLAND_DISPLAY=$WAYLAND_DISPLAY" \
              --noblacklist=/dev/snd $argv
            '';
          };
        };
      };
    };
  };
}

