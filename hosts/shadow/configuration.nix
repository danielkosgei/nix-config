{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable Experimental Features and Package Management
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Systemd stuff 
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "grpahical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Bootloader and Filesystems 
  boot = {
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
          style = "spyware";
          icon = "color";
          resolution = "1080p";
        };
        enable = true;
        devices = [ "nodev" ];
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

  # Enable Display Manager
  # services.greetd = {
  #  enable = true;
  #  settings = {
  #    default_session = {
  #      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
  #      user = "greeter";
  #    };
  #  };
  #};

  # Enable Networking
  networking = {
    hostName = "shadow";
    networkmanager.enable = true;
    # firewall.allowedTCPPorts = [ 80 443 ];
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
    # Desktop Environment
    # xserver = {
    #  enable = true;
    #   displayManager.sddm.enable = true;
    #};
    # desktopManager.plasma6.enable = true;

    # Sound with pipewire
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    # Printing
    # printing.enable = true;

    # File Management
    gvfs.enable = true;
    tumbler.enable = true;

    # SSD
    fstrim.enable = true;

    # OpenSSH daemon
    # openssh.enable = true;

    tlp = {
      enable = true;
      settings = {
      	CPU_SCALING_GOVERNOR_ON_AC = "performance";
	CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

	CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
	CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

	CPU_MIN_PERF_ON_AC = 0;
	CPU_MAX_PERF_ON_AC = 100;
	CPU_MIN_PERFORMANCE_ON_BAT = 0;
	CPU_MAX_PERF_ON_BAT = 20;

	#Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
    };
    
  };

  # Enable Window Manager
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      # xwayland.enable = true;
    };
  };

  # Security
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  
  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Fonts
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
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
  
  #virtualisation.docker.rootless = {
    #enable = true;
    #setSocketVariable = true;
  #};
  
  virtualisation.docker = {
    enable = true;
  };
  # User account
  users.users.danny = {
    isNormalUser = true;
    description = "danny";
    extraGroups = [ "docker" "networkmanager" "wheel" "disk" "power" "video" ];
    packages = with pkgs; [
    	devenv
    ];
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
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
    # Shell
    zsh.enable = true;

    # Thunar 
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    # Programs that need SUID wrappers
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
   vim
   wget
   cmake
   # greetd.tuigreet
  ];

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # KDE Connect
  # kdeconnect.enable = true

  #environment.sessionVariables.NIXOS_OZONE_WL = "1";
  #environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # xdg
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
    #  xdg-desktop-portal-hyprland
    ];
    # wlr.enable = true;
  };

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
  system.stateVersion = "24.05"; # Did you read the comment?

}
