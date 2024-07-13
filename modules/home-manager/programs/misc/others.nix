{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    hyprpaper
    grim
    brightnessctl
    zathura
    htop
    firefox
    qbittorrent
    pavucontrol
    pamixer
    ripgrep
    xdg-utils
    neofetch
    htop
    chromium
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
