{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    android-studio
    jetbrains.idea-community
    qtcreator
    vscode
    zed-editor
    neofetch
  ];
}
