{ pkgs, ... }:

{
  # Allow fontconfig to use fonts installed by Home Manager.
  fonts.fontconfig.enable = true;
  # Install some useful fonts by default.
  home.packages = with pkgs; [
    iosevka
    jost
    meslo-lgs-nf
    noto-fonts
    noto-fonts-cjk
    source-sans-pro
  ];
}
