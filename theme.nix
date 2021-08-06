{ pkgs, ... }:

{
  gtk.enable = true;
  gtk.theme = {
    name = "Paper";
    package = pkgs.paper-gtk-theme;
  };
  gtk.iconTheme = {
    name = "Paper";
    package = pkgs.paper-icon-theme;
  };
  # No proper way to set the cursor theme (yet).
  # https://github.com/NixOS/nixpkgs/issues/22652
  gtk.gtk2.extraConfig = ''gtk-cursor-theme-name = "Paper"'';
  gtk.gtk3.extraConfig = {
    gtk-cursor-theme-name = "Paper";
  };
  home.file.".icons/default/index.theme".text = ''
    [Icon Theme]
    Inherits=Paper
  '';
  home.sessionVariables.XCURSOR_THEME = "Paper";
}
