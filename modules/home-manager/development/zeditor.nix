{ pkgs, lib, ... }:

{
  # Install language servers and tools
  home.packages = with pkgs; [
    # Nix
    nil

    # Rust
    rust-analyzer

    # JavaScript/TypeScript/Node
    nodejs
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted # HTML, CSS, JSON, ESLint

    # Go
    gopls
    delve # Go debugger

    # PHP/Laravel
    nodePackages.intelephense

    # Python
    pyright

    # Markdown
    marksman

    # YAML
    yaml-language-server

    # Docker
    dockerfile-language-server

    # SQL
    sqls

    # Kotlin
    kotlin-language-server

    # Shell scripts
    nodePackages.bash-language-server

    # Formatters
    nixpkgs-fmt # Nix formatter
    nodePackages.prettier # JS/TS/JSON/YAML/Markdown
    black # Python formatter
    gofumpt # Go formatter
    phpactor # PHP tools
  ];

  programs.zed-editor = {
    enable = true;

    ## Auto-install extensions
    extensions = [
      "nix"
      "toml"
      "html"
      "dockerfile"
      "env"
      "sql"
      "kotlin"
      "php"
      "prisma"
    ];

    ## Zed editor settings
    userSettings = {
      # Assistant configuration
      assistant = {
        enabled = true;
        version = "2";
        default_model = {
          provider = "zed.dev";
          model = "claude-3-5-sonnet-latest";
        };
      };

      # Node configuration
      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };

      # General settings
      hour_format = "hour24";
      auto_update = false;
      vim_mode = false;
      base_keymap = "VSCode";

      # Autosave settings
      autosave = "on_focus_change"; # or "on_window_change" or "after_delay"
      autosave_delay = 1000; # milliseconds (if using after_delay)

      # Format on save
      format_on_save = "on";

      # Theme
      theme = {
        mode = "system";
        light = "Gruvbox Light Hard";
        dark = "Gruvbox Dark Hard";
      };

      # Display
      show_whitespaces = "selection";
      ui_font_size = 16;
      buffer_font_size = 14;
      tab_size = 4;
      soft_wrap = "editor_width";

      # Terminal configuration
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        env = {
          TERM = "alacritty";
        };
        font_family = "FiraCode Nerd Font";
        line_height = "comfortable";
        shell = "system";
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };

      # LSP configuration
      lsp = {
        # Nix
        nil = {
          binary = {
            path_lookup = true;
          };
        };

        # Rust
        rust-analyzer = {
          binary = {
            path_lookup = true;
          };
        };

        # TypeScript/JavaScript
        typescript-language-server = {
          binary = {
            path_lookup = true;
          };
        };

        # Go
        gopls = {
          binary = {
            path_lookup = true;
          };
        };

        # PHP
        intelephense = {
          binary = {
            path_lookup = true;
          };
        };

        # Python
        pyright = {
          binary = {
            path_lookup = true;
          };
        };

        # Markdown
        marksman = {
          binary = {
            path_lookup = true;
          };
        };

        # YAML
        yaml-language-server = {
          binary = {
            path_lookup = true;
          };
        };

        # Docker
        dockerfile-language-server = {
          binary = {
            path_lookup = true;
          };
        };

        # SQL
        sqls = {
          binary = {
            path_lookup = true;
          };
        };

        # Kotlin
        kotlin-language-server = {
          binary = {
            path_lookup = true;
          };
        };

        # Bash
        bash-language-server = {
          binary = {
            path_lookup = true;
          };
        };

        # HTML/CSS/JSON (from vscode-langservers-extracted)
        vscode-json-language-server = {
          binary = {
            path_lookup = true;
          };
        };
      };

      # Language-specific settings
      languages = {
        "Nix" = {
          language_servers = [ "nil" ];
          tab_size = 2;
          format_on_save = "on";
          formatter = {
            external = {
              command = "nixpkgs-fmt";
            };
          };
        };

        "JavaScript" = {
          language_servers = [ "typescript-language-server" ];
          tab_size = 2;
          format_on_save = "on";
          formatter = {
            external = {
              command = "prettier";
              arguments = [ "--stdin-filepath" "{buffer_path}" ];
            };
          };
        };

        "TypeScript" = {
          language_servers = [ "typescript-language-server" ];
          tab_size = 2;
          format_on_save = "on";
          formatter = {
            external = {
              command = "prettier";
              arguments = [ "--stdin-filepath" "{buffer_path}" ];
            };
          };
        };

        "TSX" = {
          language_servers = [ "typescript-language-server" ];
          tab_size = 2;
          format_on_save = "on";
          formatter = {
            external = {
              command = "prettier";
              arguments = [ "--stdin-filepath" "{buffer_path}" ];
            };
          };
        };

        "Go" = {
          language_servers = [ "gopls" ];
          tab_size = 4;
          format_on_save = "on";
          formatter = {
            external = {
              command = "gofumpt";
            };
          };
        };

        "PHP" = {
          language_servers = [ "intelephense" ];
          tab_size = 4;
          format_on_save = "on";
        };

        "Python" = {
          language_servers = [ "pyright" ];
          tab_size = 4;
          format_on_save = "on";
          formatter = {
            external = {
              command = "black";
              arguments = [ "-" ];
            };
          };
        };

        "Markdown" = {
          language_servers = [ "marksman" ];
          tab_size = 2;
          soft_wrap = "editor_width";
        };

        "YAML" = {
          language_servers = [ "yaml-language-server" ];
          tab_size = 2;
          format_on_save = "on";
        };

        "Dockerfile" = {
          language_servers = [ "dockerfile-language-server" ];
          tab_size = 2;
        };

        "SQL" = {
          language_servers = [ "sqls" ];
          tab_size = 2;
        };

        "Kotlin" = {
          language_servers = [ "kotlin-language-server" ];
          tab_size = 4;
        };
      };

      # Load direnv for per-project environments
      load_direnv = "shell_hook";

      # File associations
      file_types = {
        "Dockerfile" = [ "Dockerfile*" ];
        "ENV" = [ ".env" ".env.*" ];
      };
    };
  };
}
