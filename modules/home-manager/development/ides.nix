{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    android-studio
    jetbrains.idea-ultimate
    jetbrains.writerside
    jetbrains.rider
    jetbrains.aqua
    jetbrains.datagrip
    zed-editor
    vscode
  ];
}
