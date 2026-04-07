{ self, inputs, ... }: {
  flake.nixosModules.spicetify = { pkgs, ... }:
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      imports = [
        inputs.spicetify-nix.nixosModules.default
      ];

      programs.spicetify = {
        enable = true;
        enabledCustomApps = with spicePkgs.apps; [
          marketplace
          lyricsPlus
        ];
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          shuffle
        ];
        theme = spicePkgs.themes.onepunch;
      };
    };
}
