{ ... }:

{
  # Workaround for "Unit tray.target not found" when starting e.g. flameshot
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Workaround for Home Manager packaging issues";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
