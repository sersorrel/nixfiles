{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pkgs.gnome.gnome-calculator
  ];
}
