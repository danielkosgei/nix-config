{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      dbaeumer.vscode-eslint
      eamodio.gitlens
      esbenp.prettier-vscode
      ms-azuretools.vscode-docker
      rust-lang.rust-analyzer
      svelte.svelte-vscode
      tamasfe.even-better-toml
    ];

    # Proper Nix attribute set for userSettings
    userSettings = {
      # Editor Settings
      "editor.fontFamily" = "Agave Nerd Font Mono, Consolas, 'Courier New', monospace";
      "editor.fontSize" = 16;
      "editor.lineHeight" = 1.5;
      "editor.wordWrap" = "on";
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "editor.detectIndentation" = true;
      "editor.formatOnSave" = true;
      "editor.minimap.enabled" = false;
      "editor.rulers" = [80];
      "editor.renderWhitespace" = "boundary";
      "editor.renderControlCharacters" = false;
      "editor.autoClosingBrackets" = "always";
      "editor.autoClosingQuotes" = "always";
      "editor.autoSurround" = "languageDefined";
      "editor.snippetSuggestions" = "top";
      "editor.parameterHints" = true;
      "editor.quickSuggestions" = true;

      # Window Settings
      "window.zoomLevel" = 0;
      #"window.title" = "${rootName} - Visual Studio Code";
      "window.restoreWindows" = "all";

      # Files Settings
      "files.autoSave" = "onWindowChange";
      "files.autoSaveDelay" = 1000;
      "files.trimTrailingWhitespace" = true;
      "files.insertFinalNewline" = true;
      "files.exclude" = {
        "**/.git" = true;
        "**/.svn" = true;
        "**/.hg" = true;
        "**/.DS_Store" = true;
        "**/*.log" = true;
      };
      "files.exclude" = {
        "**/node_modules" = true;
        "**/bower_components" = true;
      };

      # Search Settings
      "search.useIgnoreFiles" = true;
      "search.exclude" = {
        "**/node_modules" = true;
        "**/bower_components" = true;
      };

      # Terminal Settings
      "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.cursorStyle" = "block";
      "terminal.integrated.shell.linux" = "/usr/bin/bash";

      # Debugging Settings
      "debug.openDebug" = "openOnDebugBreak";
      "debug.console.fontSize" = 14;
      "debug.console.scrollback" = 10000;

      # Git Settings
      "git.enabled" = true;
      "git.autorefresh" = true;
      "git.confirmSync" = false;

      # Python Settings
      "python.pythonPath" = "/usr/bin/python3";
      "python.formatting.provider" = "autopep8";
      "python.linting.enabled" = true;
      "python.linting.pylintEnabled" = true;

      # JavaScript/TypeScript Settings
      "javascript.implicitProjectConfig.checkJs" = true;
      "typescript.tsdk" = "/usr/local/lib/node_modules/typescript/lib";
      
      # Eslint & Prettier
      "eslint.enable" = true;
      "eslint.autoFixOnSave" = true;
      "prettier.requireConfig" = true;

      # Workbench Settings
      "workbench.colorTheme" = "Default Dark+";
      "workbench.iconTheme" = "vs-seti";
      "workbench.activityBar.visible" = true;
      "workbench.sideBar.location" = "left";
      "workbench.statusBar.visible" = true;
      
      # Miscellaneous
      "editor.formatOnType" = true;
      "editor.smoothScrolling" = true;
      "editor.quickSuggestionsDelay" = 10;
    };
  };
}
