{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    htop
    qbittorrent
    ripgrep
    vesktop
    fastfetch
    obsidian
    libreoffice
    google-chrome
    kodi-wayland
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron"
      ];
    };
  };
}
