{ pkgs, ... }:

let
  unstable = import <nixos-unstable> { overlays = import ../overlays.nix; };
in
{
  home.packages = with pkgs; [
    # it's nice to have the version with --enable-libnotify, which isn't in 21.05
    unstable.rhythmbox
  ];
}
