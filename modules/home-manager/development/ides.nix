{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    vscode
    android-studio
    #    jetbrains.idea-community
    qtcreator
  ];
}
