{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;

      # ── Wayland environment variables ─────────────────────────────────────
      env = {
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        MOZ_ENABLE_WAYLAND = "1";
        GDK_BACKEND = "wayland";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
        XCURSOR_THEME = "Bibata-Modern-Classic";
        XCURSOR_SIZE = "24";
      };

      settings = {
        prefer-no-csd = true;
        hotkey-overlay = {
          skip-at-startup = null;
        };

        # Compositor / root pointer (env alone is not always enough on niri)
        cursor = {
          xcursor-theme = "Bibata-Modern-Classic";
          xcursor-size = 24;
        };

        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];
        spawn-sh-at-startup = [
          "${lib.getExe pkgs.swaybg} -i /home/dd0n3/Pictures/Wallpapers/wallhaven_pokg2e.jpg -m fill"
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        # ── Input ───────────────────────────────────────────────────────────
        input = {
          focus-follows-mouse = null;
          keyboard = {
            xkb.layout = "us";
            repeat-delay = 250;
            repeat-rate = 50;
          };
          touchpad = {
            tap = null;
            natural-scroll = null;
            accel-speed = 0.2;
          };
          mouse = {
            accel-speed = 0.0;
          };
        };

        # ── Output ──────────────────────────────────────────────────────────
        outputs."eDP-1" = {
          scale = 1.0;
          transform = "normal";
        };

        # ── Layout ──────────────────────────────────────────────────────────
        layout = {
          gaps = 5;
          border = {
            width = 2;
            active-color = "#504945";
            inactive-color = "#282828";
          };
          focus-ring = {
            off = null;
          };
          preset-column-widths = [
            { proportion = 0.5; }
            { proportion = 0.666667; }
            { proportion = 1.0; }
          ];
        };

        # ── Window rules ────────────────────────────────────────────────────
        window-rules = [
          {
            geometry-corner-radius = 12;
            clip-to-geometry = true;
          }
          {
            matches = [{ app-id = "zen"; }];
            open-on-workspace = "2";
          }
          {
            matches = [{ title = "Open File"; }];
            open-floating = true;
          }
          {
            matches = [{ app-id = "polkit-gnome-authentication-agent-1"; }];
            open-floating = true;
          }
        ];

        # ── Binds ───────────────────────────────────────────────────────────
        binds = {
          # Apps
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+Q".close-window = null;
          "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          "Mod+L".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call lockScreen lock";
          "Mod+B".spawn-sh = "zen";
          "Mod+E".spawn-sh = "${lib.getExe pkgs.kitty} -e ${lib.getExe pkgs.lf}";

          # Focus
          "Mod+H".focus-column-left = null;
          "Mod+J".focus-window-down = null;
          "Mod+K".focus-window-up = null;
          "Mod+Right".focus-column-right = null;
          "Mod+Left".focus-column-left = null;
          "Mod+Down".focus-window-down = null;
          "Mod+Up".focus-window-up = null;
          "Mod+Tab".focus-window-previous = null;

          # Move windows
          "Mod+Shift+H".move-column-left = null;
          "Mod+Shift+J".move-window-down = null;
          "Mod+Shift+K".move-column-right = null;
          "Mod+Shift+L".move-column-right = null;
          "Mod+Shift+Right".move-column-right = null;
          "Mod+Shift+Left".move-column-left = null;
          "Mod+Shift+Down".move-window-down = null;
          "Mod+Shift+Up".move-window-up = null;

          # Window state
          "Mod+F".fullscreen-window = null;
          "Mod+Shift+F".toggle-window-floating = null;
          "Mod+R".switch-preset-column-width = null;

          # Workspaces
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+Shift+1".move-window-to-workspace = 1;
          "Mod+Shift+2".move-window-to-workspace = 2;
          "Mod+Shift+3".move-window-to-workspace = 3;
          "Mod+Shift+4".move-window-to-workspace = 4;
          "Mod+Shift+5".move-window-to-workspace = 5;

          # Screenshot
          "Print".screenshot = null;
          "Mod+Print".screenshot-screen = null;

          # Media keys
          "XF86AudioLowerVolume".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call volume decrease";
          "XF86AudioRaiseVolume".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call volume increase";
          "XF86AudioMute".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call volume muteOutput";
          "XF86MonBrightnessUp".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call brightness increase";
          "XF86MonBrightnessDown".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call brightness decrease";
        };
      };
    };
  };
}
