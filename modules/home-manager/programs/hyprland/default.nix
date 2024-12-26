{ inputs, ... }: 
{
  imports = [ (import ./hyprpaper.nix) ]
    ++ [ (import ./config.nix) ];
    #++ [ (import ./hyprpaper.nix) ];
}
