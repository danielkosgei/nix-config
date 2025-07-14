{
  config,
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: let
  hostname = osConfig.networking.hostName or "unknown";
in {
  home.username = "danny";
  home.homeDirectory = "/home/danny";

  imports =
    [
      # Core modules - always loaded on all hosts
      ../../modules/tui/cli-tools
      ../../modules/tui/git
      ../../modules/tui/ssh
      ../../modules/tui/starship
      ../../modules/tui/fish
    ]
    ++ lib.optionals (hostname == "shadow") [
      # Personal laptop modules
      ../../modules/tui/kitty
      ../../modules/gui/apps
      ../../modules/gui/obsidian
      ../../modules/gui/zen-browser
    ];

  # Host-specific environment variables
  home.sessionVariables =
    {
      EDITOR = "nvim";
    };

  home.stateVersion = "25.05";
}
