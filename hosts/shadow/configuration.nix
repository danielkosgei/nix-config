{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Enable Experimental Features and Package Management
  nix = {
    extraOptions = ''
      trusted-users = root danny
    '';
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
  };

  # Bootloader and Filesystems
  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_zen;
    supportedFilesystems = ["ntfs" "exfat" "mtpfs"];
    loader = {
      timeout = 3;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        dedsec-theme = {
          enable = true;
          style = "compact";
          icon = "color";
          resolution = "1080p";
        };
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
        extraEntries = ''
          menuentry "Reboot" {
            reboot
          }
          menuentry "Poweroff" {
            halt
          }
        '';
      };
    };
  };

  # Enable Networking
  networking = {
    hostName = "shadow";
    networkmanager.enable = true;
    firewall = rec {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
    };
  };

  # Set your time zone.
  time.timeZone = "Africa/Nairobi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Services
  services = {
    xserver = {
      enable = true;
      videoDrivers = ["modesetting" "fbdev"];
    };
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    # Sound with pipewire
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    # bluetooth
    #   blueman.enable = true;

    # Printing
    # printing.enable = true;

    # SSD
    fstrim.enable = true;

    # OpenSSH daemon
    # openssh.enable = true;
  };

  # Security
  security = {
    rtkit.enable = true;
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions"
              )
            )
          {
            return polkit.Result.YES;
          }
        })
      '';
    };
  };

  hardware = {
    # OpenGL
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    # Bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  # Fonts
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Meslo LG M Regular Nerd Font Complete Mono"];
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

  virtualisation.docker = {
    enable = false;
  };

  # User account
  users.users.danny = {
    isNormalUser = true;
    description = "danny";
    extraGroups = ["adb" "docker" "networkmanager" "wheel" "disk" "power" "video"];
    packages = with pkgs; [
      devenv
      kdePackages.kate
    ];
    shell = pkgs.nushell;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "danny" = import ./home.nix;
    };
  };

  # Allow unfree packages and insecure packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowInsecure = true;
      allowUnsupportedSystem = true;
      PermittedInsecurePackages = [
      ];
    };
  };

  # Configure programs
  programs = {
    adb.enable = true;
    # Hyprland
    hyprland = {
      enable = true;
      # set the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    # Programs that need SUID wrappers
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Thunar
    xfconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    # KDE Connect
    kdeconnect.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

    gamemode.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment = {
    sessionVariables = {
      #NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      st
      vim
      wget
      cmake
      kdePackages.karousel
      kdePackages.krohnkite

      protonup
      mangohud
      heroic
    ];
  };

  #environment.sessionVariables.NIXOS_OZONE_WL = "1";
  #environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
