{ self, inputs, ... }: {
  flake.nixosModules.git = { pkgs, ... }: {
    programs.git = {
      enable = true;
      config = {
        user = {
          name = "Daniel Kosgei";
          email = "dannykosgei@gmail.com";
        };
        init.defaultBranch = "master";
        credential.helper = "store";
      };
    };

    environment.systemPackages = with pkgs; [
      gh
      git-lfs
    ];
  };
}
