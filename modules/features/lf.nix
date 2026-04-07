{ self, inputs, ... }: {
  flake.nixosModules.lf = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      lf
      kitty
      bat
      pistol
      file
      jq
      unzip
      atool
      poppler-utils
      ffmpegthumbnailer
      chafa
      mediainfo
      tree
    ];

    environment.sessionVariables.LF_CONFIG_HOME = "/etc/lf";

    environment.etc."lf/lfrc".source = ./lf/lfrc;
    environment.etc."lf/preview.sh".source = ./lf/preview.sh;
    environment.etc."lf/preview.sh".mode = "0755";
    environment.etc."lf/clean.sh".source = ./lf/clean.sh;
    environment.etc."lf/clean.sh".mode = "0755";
  };
}
