{ config, lib, pkgs, ... }:

{
  home.file.".ssh/config" = lib.mkIf (config.secrets.ssh != null) {
    text = config.secrets.ssh;
  };
}
