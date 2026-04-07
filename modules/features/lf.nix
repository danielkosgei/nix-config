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
      p7zip
      unrar
      poppler-utils
      ffmpegthumbnailer
      chafa
      mediainfo
      tree
    ];

    environment.sessionVariables.LF_CONFIG_HOME = "/etc/lf";

    # builtins.readFile avoids nixpkgs-fmt corrupting this file (it splits `set` lines).
    environment.etc."lf/lfrc".text = builtins.readFile ./lf/lfrc;
    environment.etc."lf/preview.sh".source = ./lf/preview.sh;
    environment.etc."lf/preview.sh".mode = "0755";
    environment.etc."lf/clean.sh".source = ./lf/clean.sh;
    environment.etc."lf/clean.sh".mode = "0755";
  };
}
