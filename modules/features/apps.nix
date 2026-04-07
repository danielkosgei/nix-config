{ self, inputs, ... }: {
  flake.nixosModules.apps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      mpv
      zathura
      lf
      vesktop
      fastfetch
      obsidian
      spotify
    ];
  };
}
