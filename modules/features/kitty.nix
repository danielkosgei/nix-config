{ self, inputs, ... }: {
  flake.nixosModules.kitty = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      kitty
    ];

    environment.etc."xdg/kitty/kitty.conf".source = ./kitty/kitty.conf;
  };
}
