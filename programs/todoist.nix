{ pkgs, ... }:

let
  unstable = import <nixos-unstable> { overlays = import ../overlays.nix; };
in
{
  home.packages = with pkgs; [
    # backport https://github.com/NixOS/nixpkgs/pull/135825 due to https://github.com/NixOS/nixpkgs/pull/143131 and https://github.com/NixOS/nixpkgs/issues/116101
    (assert builtins.compareVersions todoist-electron.version "0.2.4" == 0; unstable.todoist-electron)
  ];
}
