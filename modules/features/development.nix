{ self, inputs, ... }: {
  flake.nixosModules.development = { pkgs, ... }:
    let
      traeIde = pkgs.writeShellApplication {
        name = "trae-ide";
        runtimeInputs = with pkgs; [
          curl
          appimage-run
        ];
        text = ''
          set -euo pipefail

          app_dir="$HOME/.local/share/trae"
          app_image="$app_dir/Trae-linux-x64.AppImage"
          app_url="https://releases.trae.ai/latest/Trae-linux-x64.AppImage"

          mkdir -p "$app_dir"

          if [ ! -x "$app_image" ]; then
            echo "Downloading Trae IDE AppImage..."
            curl -fL "$app_url" -o "$app_image"
            chmod +x "$app_image"
          fi

          exec appimage-run "$app_image" "$@"
        '';
      };

      php = pkgs.php.buildEnv {
        extensions = ({ enabled, all }:
          enabled
          ++ (with all; [
            bcmath
            curl
            intl
            mbstring
            opcache
            openssl
            pcntl
            pdo_mysql
            pdo_pgsql
            pdo_sqlite
            redis
            sodium
            zip
          ]));
        extraConfig = ''
          memory_limit = 512M
          upload_max_filesize = 64M
          post_max_size = 64M
          max_execution_time = 120
          max_input_vars = 5000

          display_errors = On
          display_startup_errors = On
          error_reporting = E_ALL

          opcache.enable = 1
          opcache.enable_cli = 1
          opcache.validate_timestamps = 1
          opcache.revalidate_freq = 0
        '';
      };
    in
    {
      environment.systemPackages = with pkgs; [
        code-cursor-fhs
        kiro-fhs
        traeIde

        # JavaScript / TypeScript / Svelte
        nodejs
        bun
        deno
        pnpm
        yarn
        typescript
        typescript-language-server
        eslint
        prettier
        svelte-language-server

        # PHP / Laravel
        php
        php84Packages.composer
        phpactor
        phpunit
        phpstan
        psysh

        # Containers / infra
        podman
        podman-compose

        # C / C++
        gcc
        clang
        clang-tools
        gnumake
        cmake
        ninja
        pkg-config
        gdb
        lldb
        valgrind

        # General utilities
        license-generator
        inetutils
        postgresql
        ngrok

        # Python
        python3
        python313Packages.pip
        uv
        poetry
        black
        isort
        ruff
        mypy
        pyright
        basedpyright

        ripgrep

        # Rust
        rustup
        wasm-pack

        # Go
        go
        gopls
        delve
        golangci-lint
        gotools
      ];
    };
}
