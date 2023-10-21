{ config, pkgs, ... }:

let
  # gruvboxPlus = import ./gruvbox-plus.nix { inherit pkgs; };
in

{
  
  home.username = "enchanted-coder";
  home.homeDirectory = "/home/enchanted-coder";

  
  home.stateVersion = "23.05"; 

   
  # enable gtk
  gtk = {
    enable = true;
    theme = {
      package = pkgs.materia-theme;
      name = "Materia-dark-compact";
    };
    iconTheme = {
      package = pkgs.paper-icon-theme;
      name = "Paper";
    };
  };

  # configure cursor  
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    git
    gh
    nodejs
    jdk
    mpv
    bat 
    virt-manager
    unzip
    p7zip
    gnome.file-roller
    imv
    R
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
     })
    )
    mako 
    libnotify
    hyprpaper
    rofi-wayland
    neofetch
    brightnessctl
    lf 
    zathura
    htop
    firefox
    neovim
    vscode
    spotify
    obsidian
    qbittorrent
    libreoffice-still
    obs-studio
    eww-wayland
    jetbrains.pycharm-professional
    lxmenu-data
    shared-mime-info
  ];

  
  home.file = {
    

  };

 
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  

  # enable qt
  qt.enable = true;

  qt.platformTheme = "gtk";

  qt.style.name = "adwaita-dark";

  qt.style.package = pkgs.adwaita-qt; 

  programs.home-manager.enable = true;
}
