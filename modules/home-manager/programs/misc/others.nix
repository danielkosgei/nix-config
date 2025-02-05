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
    nitch
    obsidian
    libreoffice
    signal-desktop
    kdePackages.kdenlive
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
