{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.hyprpaper ];
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/shadow/modules/home-manager/programs/hyprland/wallpapers/nixos.png"
      ];
      wallpaper = [
        "eDP-1,~/shadow/modules/home-manager/programs/hyprland/wallpapers/nixos.png"
      ];
    };
  };
}
