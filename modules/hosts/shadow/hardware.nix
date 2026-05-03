{ self, inputs, ... }: {
  flake.nixosModules.shadowHardware = { config, lib, pkgs, modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    fileSystems."/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };
    
    fileSystems."/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ]; 
    };  

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    # Swap is currently not defined in this repo; enabling zram helps avoid OOM kills
    # during heavy builds on low-RAM systems.
    zramSwap = {
      enable = true;
      memoryPercent = 100;
      algorithm = "zstd";
    };

    # Userspace OOM handling pairs well with zram and helps avoid hard lockups
    # when memory pressure spikes during large builds.
    systemd.oomd.enable = true;
  };
}
