{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
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
        efiSysMountPoint = "/boot/efi";
      };
    #  systemd-boot.enable = true;
      grub = {
        #dedsec-theme = {
        #  enable = true;
        #  style = "reaper";
        #  icon = "color";
        #  resolution = "1080p";
        #};
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

  # Bootloader
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "shadow";
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "Africa/Nairobi";

  # Internationalization
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable hardware graphics acceleration
  hardware.graphics.enable = true;

  # Enable bluetooth
  # hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  # Enable the X11 windowing system
  #services.xserver.enable = true;

  # Enable Intel iGPU support
  #services.xserver.videoDrivers = ["modesetting"];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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

  # Define a user account
  users.users.danny = {
    isNormalUser = true;
    description = "danny";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };

  # Enable fish shell system-wide
  programs.fish.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    wget
    vim
    fish
    kdePackages.kdenlive
  ];

  # SSD
  services.fstrim.enable = true;

  system.stateVersion = "25.05";
}
