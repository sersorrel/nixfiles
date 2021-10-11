{ config, pkgs, ... }:

{
  home.sessionVariables.NIX_SCRIPT_CACHE_PATH = "${config.xdg.cacheHome}/nix-script";
  home.packages = with pkgs; [
    (
      import (
        fetchFromGitHub {
          owner = "sersorrel";
          repo = "nix-script";
          rev = "bb82ca89f3169ec93bcd3d7dfd2ace3d76527abd";
          sha256 = "1bz79ykfxqp1an5iyjnrcfyyp1gdrg9hg2zfb7kg77jhdpk6vr8j";
        }
      ) {}
    )
  ];
}
