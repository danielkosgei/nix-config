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
