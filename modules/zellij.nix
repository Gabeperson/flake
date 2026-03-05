{ config, lib, pkgs, user, ... }:

let
  cfg = config.features.zellij;
in {
  options.features.zellij = {
    enable = lib.mkEnableOption "Zellij"; 
  }; 

  config = {
    environment.systemPackages = [ pkgs.zellij ];
    home-manager.users.${user} = {
      programs.zellij = {
        enable = true;
        extraConfig = ''
          show_startup_tips false
          pane_frames false
          on_force_close "quit"
        '';
        layouts = {
          default = {
            layout = {
              _children = [
                # {
                #   pane = {
                #     size = 1;
                #     borderless = true;
                #     plugin = {
                #       location = "tab-bar";
                #     };
                #   };
                # }
                {
                  pane = {};
                }  
                {
                  pane = {
                    size = 1;
                    borderless = true;
                    plugin = {
                      location = "status-bar";
                    };
                  };
                }
              ];
            };
          };
        };
      };
    };
  };
}
