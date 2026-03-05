{ config, lib, pkgs, ... }:

let
  cfg = config.features.chromium;
in {
  options.features.chromium = {
    enable = lib.mkEnableOption "Chromium";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.chromium ];

    programs.chromium = {
      enable = true;
      # homepageLocation = "";
      extensions = [
        # If regular id doesn't work, <id>;https://clients2.google.com/service/update2/crx
        # uBlock Origin (Full)
        "cjpalhdlnbpafiamejdnhcphjbkeiagm"
        # uBlock Origin (lite)
        "ddkjiahejlhfcafbddmgiahcphecmpfh"
        # Dark Reader
        "eimadpbcbfnmbkopoojfekhnkhdbieeh"
        # Bitwarden
        "nngceckbapebfimnlniiiahkandclblb"
        # Sponsorblock
      ];
      extraOpts = {
        "BrowserSignin" = 0;
        "SyncDisabled" = true;
        "PasswordManagerEnabled" = false;
        "BuiltInDnsClientEnabled" = false;
        "DeviceMetricsReportingEnabled" = false;
        "ReportDeviceCrashReportInfo" = false;
        "SpellcheckEnabled" = true;
        "SpellcheckLanguage" = [ "en-CA" "ko-KR" ];
        "CloudPrintSubmitEnabled" = false;
        "BrowserCheckDefaultBrowser" = false;
        "BrowserCheckDefaultBrowserEnabled" = false;
      };
    };
  };
}
