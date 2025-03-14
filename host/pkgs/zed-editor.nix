{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        zed-editor
    ];

    environment.etc."zed/settings.jsonc".text = ''
      {
        "telemetry": {
          "diagnostics": false,
          "metrics": false
        },
        "icon_theme": "VSCode Icons (Dark)",
        "buffer_font_family": "Zed Plex Mono",
        "buffer_font_fallbacks": ["Nerd Font"],
        "ui_font_family": "Zed Plex Sans",
        "font_family": "Noto Nerd Font",
        "ui_font_size": 16,
        "buffer_font_size": 16,
        "formatter": {
          "external": {
            "command": "prettier",
            "arguments": ["--stdin-filepath", "{buffer_path}"]
          }
        },
        "languages": {
          "Shell Script": {
            "format_on_save": "on",
            "formatter": {
              "external": {
                "command": "shfmt",
                // Change `--indent 2` to match your preferred tab_size
                "arguments": ["--filename", "{buffer_path}", "--indent", "2"]
              }
            }
          },
          "Markdown": {
            "enable_language_server": false
          },
          "JSON": {
            "tab_size": 4,
            "code_actions_on_format": {
              "source.fixAll.eslint": true
            }
          },
          "TypeScript": {
            "language_servers": ["typescript-language-server", "!vtsls", "..."],
            "code_actions_on_format": {
              "source.organizeImports": true
            }
          },
          "TSX": {
            "language_servers": ["typescript-language-server", "!vtsls", "..."],
            "code_actions_on_format": {
              "source.organizeImports": true
            }
          },
          "JavaScript": {
            "tab_size": 2,
            "language_servers": ["typescript-language-server", "!vtsls", "..."],
            "code_actions_on_format": {
              "source.fixAll.eslint": true
            },
            "formatter": {
              "external": {
                "command": "prettier",
                "arguments": ["--stdin-filepath", "{buffer_path}"]
              }
            },
            "format_on_save": "on"
          },
          "Lua": {
            "format_on_save": "on",
            "formatter": "language_server"
          }
        },
        "lsp": {
          "vtsls": {
            "settings": {
              // For TypeScript:
              "typescript": { "tsserver": { "maxTsServerMemory": 16184 } },
              // For JavaScript:
              "javascript": { "tsserver": { "maxTsServerMemory": 16184 } }
            }
          },
          "taplo": {
            "settings": {
              "array_auto_collapse": false
            }
          },
          "json-language-server": {
            "settings": {
              "json": {
                "schemas": [
                  {
                    "fileMatch": ["*/*.luarc.json"],
                    "url": "https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json"
                  }
                ]
              }
            }
          },
          "typescript-language-server": {
            "initialization_options": {
              // These are not supported (VSCode dotted style):
              // "preferences.strictNullChecks": true,
              // "preferences.target": "ES2020"
              //
              // These is correct (nested notation):
              "preferences": {
                "strictNullChecks": true,
                "target": "ES2020"
              },
            }
          },
          "eslint": {
            "settings": {
              "codeActionOnSave": {
                "rules": ["import/order"]
              }
            }
          }
        },
        "file_scan_exclusions": [
          "**/.git",
          "**/.svn",
          "**/.hg",
          "**/.jj",
          "**/CVS",
          "**/.DS_Store",
          "**/Thumbs.db",
          "**/.classpath",
          "**/.settings"
        ],
        "format_on_save": "on",
        "centered_layout": {
	  "left_padding": 0.2,
	  "right_padding": 0.2,
	},
	"features": {
	 "edit_prediction_provider": "zed"
        },
        "assistant": {
          "default_model": {
            "provider": "copilot_chat",
            "model": "gpt-4o"
          },
          "version": "2"
        },
        "scrollbar": {
          "show": "auto"
        },
        "edit_predictions": {
          "disabled_globs": [
            "**/.env*",
            "**/*.pem",
            "**/*.key",
            "**/*.cert",
            "**/*.crt",
            "**/secrets.yml"
          ]
        },
        "theme": {
          "mode": "system",
          "light": "Catppuccin Latte",
          "dark": "Catppuccin Mocha"
        },
        "autosave": "on_window_change",
        "restore_on_startup": "last_session",
        "inactive_opacity": 0.5,
        "magnification": 0.8,
        "border_size": 1,
        "base_keymap": "VSCode",
        "terminal": {
          "alternate_scroll": "off",
          "blinking": "terminal_controlled",
          "copy_on_select": false,
          "dock": "bottom",
          "detect_venv": {
            "on": {
              "directories": [".env", "env", ".venv", "venv"],
              "activate_script": "default"
            }
          },
          "env": {},
          "shell": "system",
          "font_family": "Noto Nerd Font",
          "font_features": null,
          "font_size": 14,
          "line_height": "comfortable",
          "option_as_meta": false,
          "button": false,
          "toolbar": {
            "breadcrumbs": true
          },
          "working_directory": "current_project_directory",
          "scrollbar": {
            "show": null
          }
        },
        "experimental.theme_overrides": {
          "syntax": {
            "comment": {
              "font_style": "italic"
            },
            "comment.doc": {
              "font_style": "italic"
            },
            "comment.block": {
              "font_style": "italic"
            },
            "string": {
              "color": "#42903766"
            }
          }
        }
      }
    '';
}
