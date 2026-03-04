{ config, lib, pkgs, ... }:

let
  cfg = config.features.librewolf;
in {
  options.features.librewolf = {
    enable = lib.mkEnableOption "Librewolf";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.librewolf = {
        enable = true;
        settings = {
          "webgl.disabled" = false;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.cookies" = false;
          "network.cookie.lifetimePolicy" = 0;
        };
        policies = {
          DisableFirefoxAccounts = true;
          DisableAccounts = true;
          DisableFirefoxScreenshots = true;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DontCheckDefaultBrowser = true;
          DisplayBookmarksToolbar = "newtab";
          DisplayMenuBar = "default-off";
          SearchBar = "unified";
          OfferToSaveLogins = false;
          # "allowed", "blocked", "force_installed" or "normal_installed".
          ExtensionSettings = {
            # "*".installation_mode = "blocked";
            # uBlock Origin:
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "normal_installed";
            };
            # Dark Reader
            "addon@darkreader.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
  
          Preferences = { 
            "browser.startup.page" = { Value = 3; Status = "locked" }
            "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
            "browser.cache.disk.enable" = { Value = false; Status = "locked"; };
            "widget.disable-workspace-management" = { Value = true; Status = "locked"; };
          };
        };
      };
    };
  };
}

