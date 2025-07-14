# Fish shell aliases
{
  # File operations
  ll = "eza -la";
  la = "eza -la";
  ls = "eza -l";
  lt = "eza --tree";
  tree = "eza -T";

  # Screenshots (using grimblast with notifications)
  ss = "grimblast --notify save screen"; 

  # Networking
  ping = "ping -c 5";

  # File viewing
  grep = "rg";

  # Safety nets
  rm = "rm -i";
  cp = "cp -i";
  mv = "mv -i";

  # Restart caelestia
  restart-desktop = "systemctl --user restart caelestia-shell.service";
}
