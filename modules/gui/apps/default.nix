{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # Media 
    spotify
    mpv # Video player

    # Productivity
    # libreoffice # Office suite
    obsidian # Note-taking app

    # Development
    # github-desktop # GitHub desktop client
    # postman # API development environment

    # File management

    # Internet
    qbittorrent # Torrent client
  ];
}
