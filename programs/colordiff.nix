{ pkgs, ... }:

{
  home.packages = with pkgs; [
    colordiff
  ];
}
