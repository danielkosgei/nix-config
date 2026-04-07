{ self, inputs, ... }: {
  flake.nixosModules.zathura = { pkgs, ... }: {
    environment.etc."xdg/zathura/zathurarc".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/eastack/zathura-gruvbox/master/zathura-gruvbox-dark-hard";
      sha256 = "0f4p8a88k7zxckr3024mbjb94gd89kcl49dqyrfhahsqx7p8z75z";
    };
  };
}
