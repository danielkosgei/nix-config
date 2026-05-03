{ self, inputs, ... }: {
  flake.nixosModules.apps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      mpv-unwrapped
      zathura
      lf
      fastfetch
      spotify
      htop
    ];
  };
}
