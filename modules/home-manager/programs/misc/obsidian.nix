{ pkgs, ... }:
let
  gitSyncObsidian = pkgs.writeScriptBin "git-sync-obsidian" ''
    #!/bin/sh

    VAULT_DIR="$HOME/second_brain"

    cd $VAULT_DIR || exit 1

    git pull --rebase origin main || exit 1

    if ! git diff --quiet || ! git diff --cached --quiet; then
      git add .
      git commit -m "$(date '+%Y-%m-%d %H:%M:%S')"
    fi


    git push origin main
  '';
  in {
    home.packages = [ gitSyncObsidian ];

    systemd.user.services.git-sync-obsidian = {
      Unit = {
        Description = "Sync Obsidian Vault with GitHub";
	Wants = "git-sync-obsidian.timer";
      };
      Service = {
        ExecStart = "${gitSyncObsidian}/bin/git-sync-obsidian";
	Type = "simple";
      };
    };

    systemd.user.timers.git-sync-obsidian = {
      Unit.Description = "Run Git Sync for Obsidian Vault";
      Timer.OnCalendar = "*:0/15";
      Install.WantedBy = [ "timers.target" ];
    };
 
  }
