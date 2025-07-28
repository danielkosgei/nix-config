{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    #android-studio
    #jetbrains.idea-ultimate
    #jetbrains.rider
    #jetbrains.datagrip
    vscode
  ];
}
