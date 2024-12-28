{ config, pkgs, inputs, ... }:

{

  imports = [
    ../../modules/home-manager/development
    ../../modules/home-manager/programs
  ];

  home.username = "danny";
  home.homeDirectory = "/home/danny";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
    inputs.hyprland-qtutils.packages."${pkgs.system}".default
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [

  ];

  home.file = {

  };

  home.sessionVariables = {
    BROWSER = "firefox";
    TERMINAL = "kitty";
    EDITOR = "nvim";
  };

  wayland.windowManager.hyprland = {
    enable = true;
  };

  programs.home-manager.enable = true;
}
