{ pkgs, ... }:

{
  systemd.user.timers = {
    empty-trash = {
      Unit = {
        Description = "Regularly delete trashed files";
        PartOf = [ "empty-trash.service" ];
      };
      Timer = {
        OnStartupSec = 60 * 60; # 1 hour after login
        OnUnitActiveSec = 60 * 60 * 24; # every 24 hours thereafter
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
  };
  systemd.user.services = {
    empty-trash = {
      Unit = {
        Description = "Delete old trashed files";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.trash-cli}/bin/trash-empty 28";
      };
    };
  };
}
