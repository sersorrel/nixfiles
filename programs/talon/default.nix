{ pkgs, ... }:

{
  home.packages = with pkgs; [
    talon
    talon-beta
  ];
}
