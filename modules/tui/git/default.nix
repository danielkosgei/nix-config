{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    enable = true;

    userName = "danielkosgei";
    userEmail = "dannykosgei@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;

    };
  };
}

