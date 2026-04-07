{ self, inputs, ... }: {
  flake.nixosModules.development = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      code-cursor-fhs
      nodePackages_latest.nodejs
      bun
      gcc
      gnumake
      license-generator
      inetutils
      postgresql
      supabase-cli
      ngrok
      python3
      python313Packages.pip
      ripgrep
      rustup
      wasm-pack
      go
      neovim
    ];
  };
}
