{ pkgs, ... }:
{
  gtk = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    iconTheme = {
      name = "gruvboxPlus";
      package = pkgs.gruvbox-plus-icons;
    };

    theme = {
      name = "GruvboxMaterial";
      package = pkgs.gruvbox-material-gtk-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 16;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "breeze";
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
  };
}
