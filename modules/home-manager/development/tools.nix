{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    #nodePackages_latest.nodejs
    bun
    gcc
    gnumake
    license-generator
    inetutils
    postgresql
    supabase-cli
    ngrok
    python3
    ripgrep
    rustup
    wasm-pack
  ];
}
