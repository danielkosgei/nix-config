{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    android-studio
    #jetbrains.idea-community
    zed-editor
  ];
}
