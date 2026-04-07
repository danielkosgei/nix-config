{ self, inputs, ... }: {
  flake.nixosModules.neovim = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      configure = {
        packages.gruvbox = with pkgs.vimPlugins; {
          start = [ gruvbox-nvim ];
        };
        customLuaRC = ''
          vim.o.termguicolors = true
          vim.o.number = true
          vim.o.relativenumber = true
          vim.o.expandtab = true
          vim.o.shiftwidth = 2
          vim.o.tabstop = 2
          vim.o.background = "dark"
          require("gruvbox").setup({
            contrast = "hard",
          })
          vim.cmd.colorscheme("gruvbox")
        '';
      };
    };
  };
}
