{ pkgs, ... }:

let
  talon = pkgs.callPackage ./talon.nix {};
  talon-beta = pkgs.callPackage ./talon-beta.nix {};
in
{
  home.packages = with pkgs; [
    talon
  ];
}
