{ self, inputs, ... }: {
  flake.nixosModules.apps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      mpv
      zathura
      lf
      qbittorrent
      vesktop
      fastfetch
      obsidian
      pcmanfm
      spotify
    ];
  };
}
