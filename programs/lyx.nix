{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lyx
    texlive.combined.scheme-full
  ];
}
