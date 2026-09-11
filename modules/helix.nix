{
  config,
  lib,
  pkgs,
  user,
  ...
}:

let
  cfg = config.features.helix;
in
{
  options.features.helix = {
    enable = lib.mkEnableOption "Helix Editor";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.helix ];

    home-manager.users.${user} = {
      home.file.".config/helix/themes/nightfoxt.toml" = {
        source = ../config/nightfoxt.toml;
      };
      programs.helix = {
        enable = true;
        extraPackages = [
          pkgs.uwu-colors
          pkgs.biome
          pkgs.nil
          pkgs.ruff
          pkgs.lua-language-server
          pkgs.tombi
        ];
        defaultEditor = true;
        settings = {
          theme = "nightfoxt";
          editor = {
            end-of-line-diagnostics = "hint";
            lsp = {
              display-inlay-hints = true;
            };
            true-color = true;
            line-number = "relative";
            inline-diagnostics = {
              cursor-line = "hint";
            };
          };
          keys.insert = {
            "C-backspace" = "delete_word_backward";
          };
        };
        languages = {
          language-server = {
            uwu-colors = {
              command = "uwu_colors";
            };
            rust-analyzer.config = {
              check = {
                command = "clippy";
              };
            };
            biome = {
              command = "biome";
              args = [ "lsp-proxy" ];
            };
            godot = {
              command = "nc";
              args = [
                "127.0.0.1"
                "6005"
              ];
            };
          };
          language = [
            {
              name = "rust";
              auto-format = true;
              language-servers = [
                "rust-analyzer"
                "uwu-colors"
              ];
            }
            {
              name = "nix";
              language-servers = [
                "nil"
                "uwu-colors"
              ];
            }
            {
              name = "gdscript";
              language-servers = [
                "godot"
                "uwu-colors"
              ];
            }
            {
              name = "y86";
              scope = "scope.y86";
              file-types = ["y86"];
              comment-tokens = ["//"];
            }
          ]
          ++ (lib.lists.forEach [ "javascript" "typescript" "tsx" "jsx" ] (name: {
            inherit name;
            auto-format = true;
            language-servers = [
              {
                name = "typescript-language-server";
                except-features = [ "format" ];
              }
              "biome"
              "uwu-colors"
            ];
          }))
          ++ (lib.lists.forEach [ "css" "html" "json" ] (name: {
            inherit name;
            auto-format = true;
            language-servers = [
              "biome"
              "uwu-colors"
            ];
          }));
        };
      };
    };
  };
}
