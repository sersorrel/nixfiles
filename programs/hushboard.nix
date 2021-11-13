{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in
{
  home.packages = with pkgs; [
    (assert !(pkgs ? hushboard); unstable.hushboard) # hushboard not in 21.05
  ];
}
