{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    php81
    php81Packages.composer
    nodePackages_latest.nodejs
    (python312Full.withPackages(ps: with ps; [ pygobject3 gobject-introspection pyqt6-sip]))
    # bun
    gcc
    gnumake
    license-generator
    inetutils    
  ];
}
