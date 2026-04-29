{ config, lib, pkgs, user, ... }:

let
  cfg = config.features.firefox;
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in {
  options.features.firefox = {
    enable = lib.mkEnableOption "Firefox";
  };

  config = lib.mkIf cfg.enable {

    home-manager.users.${user} = {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/about" = "firefox.desktop";
          "x-scheme-handler/unknown" = "firefox.desktop";
        };
      };
    };
    
    environment.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      LIBVA_DRIVER_NAME = if config.features.nvidia.enable then "nvidia" else "iHD";
    };
    programs.firefox = {
      enable = true;
      languagePacks = ["en-CA"];


      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
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
            default_area = "navbar";
          };
          # Indie wiki buddy:
          "{cb31ec5d-c49a-4e5a-b240-16c767444f62}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/indie_wiki_buddy/latest.xpi";
            installation_mode = "normal_installed";
            default_area = "navbar";
          };
          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "normal_installed";
            default_area = "navbar";
          };
          # Dark Reader
          "addon@darkreader.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            installation_mode = "normal_installed";
            default_area = "navbar";
          };
          "sponsorBlocker@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            installation_mode = "normal_installed";
          };
        };
  
        Preferences = { 
          "ui.key.menuAccessKeyFocuses" = false;
          "browser.startup.page" = { Value = 3; Status = "locked"; };
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.cache.disk.enable" = false;
          # "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          # "browser.urlbar.suggest.searches" = lock-false;
          # "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
          "widget.disable-workspace-management" = true;
        };
      };
    };
  };
}
