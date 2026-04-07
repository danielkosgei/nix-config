{ self, inputs, ... }: {

  flake.nixosModules.shadowConfiguration = { pkgs, lib, ... }:
    let
      zenWrapped = pkgs.wrapFirefox
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
        {
          extraPrefs = ''
            lockPref("layout.css.prefers-color-scheme.content-override", 0);
            lockPref("ui.systemUsesDarkTheme", 1);
          '';
        };
    in
    {
      imports = [
        self.nixosModules.shadowHardware
        self.nixosModules.niri
        self.nixosModules.kitty
        self.nixosModules.apps
        self.nixosModules.development
        self.nixosModules.git
        self.nixosModules.lf
        self.nixosModules.spicetify
        inputs.dedsec-grub-theme.nixosModule
      ];

      nix = {
        extraOptions = ''
          trusted-users = root dd0n3
        '';
        settings = {
          experimental-features = [ "nix-command" "flakes" ];
          auto-optimise-store = true;
        };
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
      };

      boot = {
        kernelModules = [ "battery" "ac" ];
        kernelParams = [ "acpi=on" ];
        supportedFilesystems = [ "ntfs" "exfat" "mtpfs" ];
        loader = {
          timeout = 3;
          efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
          };
          grub = {
            dedsec-theme = {
              enable = true;
              style = "reaper";
              icon = "color";
              resolution = "1080p";
            };
            enable = true;
            devices = [ "nodev" ];
            efiSupport = true;
            extraEntries = ''
              menuentry "UEFI Firmware Settings" {
                fwsetup
              }
              menuentry "Reboot" {
                reboot
              }
              menuentry "Shutdown" {
                halt
              }
            '';
          };
        };
      };

      networking = {
        hostName = "shadow";
        networkmanager.enable = true;
      };

      time.timeZone = "Africa/Nairobi";

      i18n.defaultLocale = "en_GB.UTF-8";
      console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
      };

      services = {
        xserver = {
          enable = false;
          videoDrivers = [ "modesetting" "fbdev" ];
        };
        displayManager.ly.enable = true;
        gvfs.enable = true;
        udisks2.enable = true;
        upower.enable = true;
        power-profiles-daemon.enable = true;
        pipewire = {
          enable = true;
          pulse.enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
        };
        fstrim.enable = true;
      };

      systemd.user.services.udiskie = {
        description = "Automount removable media (udiskie)";
        wantedBy = [ "default.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.udiskie}/bin/udiskie";
          Restart = "on-failure";
        };
      };

      security = {
        rtkit.enable = true;
        polkit.enable = true;
      };

      hardware = {
        bluetooth.enable = false;
        graphics = {
          enable = true;
          enable32Bit = true;
        };
      };

      fonts = {
        fontconfig = {
          enable = true;
          defaultFonts = {
            monospace = [ "JetBrainsMono Nerd Font Mono" ];
          };
        };
        packages = with pkgs; [
          nerd-fonts.agave
          nerd-fonts.jetbrains-mono
          font-awesome
          powerline-fonts
          powerline-symbols
        ];
      };

      users.users.dd0n3 = {
        isNormalUser = true;
        description = "dd0n3";
        extraGroups = [ "wheel" "networkmanager" "power" "disk" "video" ];
        packages = with pkgs; [
          tree
          git
        ];
      };

      programs = {
        mtr.enable = true;
        gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
        };
        dconf.enable = true;
      };

      environment.systemPackages = with pkgs; [
        vim
        wget
        zenWrapped
        gruvbox-gtk-theme
        gruvbox-plus-icons
        bibata-cursors
        gvfs
        udiskie
        tumbler
        ffmpegthumbnailer
        poppler-utils
        shared-mime-info
      ];

      environment.sessionVariables = {
        GTK_THEME = "Gruvbox-Dark-BL";
        ICON_THEME = "Gruvbox-Plus-Dark";
        XCURSOR_THEME = "Bibata-Modern-Classic";
        XCURSOR_SIZE = "24";
        QT_QPA_PLATFORMTHEME = "gtk3";
      };
      environment.sessionVariables.XDG_DATA_DIRS = lib.mkAfter [
        "/run/current-system/sw/share"
      ];

      environment.etc."xdg/gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-theme-name=Gruvbox-Dark-BL
        gtk-icon-theme-name=Gruvbox-Plus-Dark
        gtk-cursor-theme-name=Bibata-Modern-Classic
        gtk-cursor-theme-size=24
      '';
      environment.etc."xdg/gtk-4.0/settings.ini".text = ''
        [Settings]
        gtk-theme-name=Gruvbox-Dark-BL
        gtk-icon-theme-name=Gruvbox-Plus-Dark
        gtk-cursor-theme-name=Bibata-Modern-Classic
        gtk-cursor-theme-size=24
      '';

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [ ];
      };
      xdg.mime = {
        enable = true;
        defaultApplications = {
          "video/mp4" = [ "mpv.desktop" ];
          "video/x-matroska" = [ "mpv.desktop" ];
          "video/webm" = [ "mpv.desktop" ];
          "video/quicktime" = [ "mpv.desktop" ];
          "video/x-msvideo" = [ "mpv.desktop" ];
          "video/mpeg" = [ "mpv.desktop" ];
          "video/ogg" = [ "mpv.desktop" ];
        };
        addedAssociations = {
          "video/mp4" = [ "mpv.desktop" ];
          "video/x-matroska" = [ "mpv.desktop" ];
          "video/webm" = [ "mpv.desktop" ];
          "video/quicktime" = [ "mpv.desktop" ];
          "video/x-msvideo" = [ "mpv.desktop" ];
          "video/mpeg" = [ "mpv.desktop" ];
          "video/ogg" = [ "mpv.desktop" ];
        };
        removedAssociations = {
          "video/mp4" = [ "umpv.desktop" ];
          "video/x-matroska" = [ "umpv.desktop" ];
          "video/webm" = [ "umpv.desktop" ];
          "video/quicktime" = [ "umpv.desktop" ];
          "video/x-msvideo" = [ "umpv.desktop" ];
          "video/mpeg" = [ "umpv.desktop" ];
          "video/ogg" = [ "umpv.desktop" ];
        };
      };

      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "26.05";
    };
}
