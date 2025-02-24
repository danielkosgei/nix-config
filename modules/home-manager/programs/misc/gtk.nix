{ pkgs, ... }:
{

  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";

  home.file = {
    ".icons/gruvbox".source = "${pkgs.gruvbox-dark-icons-gtk}/share/icons/GruvboxDarkIconsGtk";
  };

  #gtk.iconTheme.package = pkgs.gruvbox-plus-icons;
  gtk.iconTheme.name = "GruvboxDarkIconsGtk";

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
  };
}
