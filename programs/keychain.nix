{ pkgs, ... }:

{
  programs.keychain = {
    enable = true;
    agents = [ "ssh" ];
    keys = [ "id_ed25519" ];
  };
}
