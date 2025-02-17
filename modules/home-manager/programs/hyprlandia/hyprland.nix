{ inputs, pkgs, ...}: 
{
  home.packages = with pkgs; [
    # swww
    # hyprpicker
    wofi
  ];
  #systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

}
