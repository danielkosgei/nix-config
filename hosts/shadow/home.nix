{ config, pkgs, system, inputs, ... }:
let
  system = "x86_64-linux";
in
{
  imports = [
    ../../modules/home-manager/development
    ../../modules/home-manager/programs
  ];

  home.username = "danny";
  home.homeDirectory = "/home/danny";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs;[
    inputs.zen-browser.packages."${system}".twilight 
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [

  ];

  home.file = {
    
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    BROWSER = "zen";

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
