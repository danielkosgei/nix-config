{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    htop
    firefox
    qbittorrent
    ripgrep
    vesktop
    fastfetch
    obsidian
    libreoffice
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
