{ config, pkgs, inputs, ... }:

{
  
  imports = [
    ../../modules/home-manager/development
    ../../modules/home-manager/programs
  ];

  home.username = "danny";
  home.homeDirectory = "/home/danny";

  home.stateVersion = "24.11"; 


  home.packages = [
    inputs.hyprland-qtutils.packages."${pkgs.system}".default 
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    
  ];

  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  wayland.windowManager.hyprland = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
