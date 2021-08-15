{ pkgs, ... }:

{
  programs.keychain = {
    enable = true;
    agents = [ "ssh" ];
    keys = [ "id_ed25519" ];
  };
  # Work around https://github.com/nix-community/home-manager/issues/2256
  programs.keychain.enableBashIntegration = false;
}
