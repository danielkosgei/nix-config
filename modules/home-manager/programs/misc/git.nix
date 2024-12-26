{ pkgs, ... }: 
{
  programs.git = {
    enable = true;
    
    userName = "Daniel Kosgei";
    userEmail = "dannykosgei@gmail.com";
    
    extraConfig = { 
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  home.packages = [ pkgs.gh pkgs.git-lfs ];
}
