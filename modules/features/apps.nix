{ self, inputs, ... }: {
  flake.nixosModules.apps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      mpv
      zathura
      lf
      transmission_4-gtk
      vesktop
      fastfetch
      obsidian
      nautilus
      spotify
    ];
  };
}
