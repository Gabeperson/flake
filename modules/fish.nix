{config, lib, pkgs, user, ...}:

let
  cfg = config.features.fish;
in {
  options.features.fish = {
    enable = lib.mkEnableOption "Fish Shell";
  };

  config = lib.mkIf cfg.enable {
    programs.bash = {
      interactiveShellInit = ''
        if grep -qv 'fish' /proc/$PPID/comm && [[ ''${SHLVL} == [1,2] ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION='''
          exec fish $LOGIN_OPTION
        fi
      '';
    };
    programs.fish.enable = true;
    home-manager.users.${user} = {
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
        '';
        plugins = [
          # { name = "tide"; src = pkgs.fishPlugins.tide.src; }
          { name = "done"; src = pkgs.fishPlugins.done.src; }
          { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
        ];
      };
    };
  };
}
