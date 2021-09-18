{ pkgs, ... }:

let
  unstable = import <nixos-unstable> { overlays = import ./overlays.nix; };
in
{
  # Allow fontconfig to use fonts installed by Home Manager.
  fonts.fontconfig.enable = true;
  # Install some useful fonts by default.
  home.packages = with pkgs; [
    (assert builtins.compareVersions iosevka.version "7.0.4" == -1; unstable.iosevka) # see https://github.com/kovidgoyal/kitty/issues/297
    jost
    meslo-lgs-nf
    noto-fonts
    noto-fonts-cjk
    source-sans-pro
  ];
}
