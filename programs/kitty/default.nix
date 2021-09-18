{ pkgs, ... }:

let
  unstable = import <nixos-unstable> { overlays = import ../../overlays.nix; };
in
{
  home.packages = with pkgs; [
    (assert builtins.compareVersions kitty.version "0.21.0" == -1; unstable.kitty) # see https://github.com/kovidgoyal/kitty/issues/297
  ];
  xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;
  xdg.configFile."kitty/open-actions.conf".source = ./open-actions.conf;
  xdg.configFile."kitty/hyperlinked_rg.py".source = ./hyperlinked_rg.py;
  xdg.configFile."kitty/hyperlinked_fd.py".source = ./hyperlinked_fd.py;
  home.sessionVariables.TERMINAL = "kitty";
}
