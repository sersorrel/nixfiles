{ ... }:

{
  home.file.".xprofile".text = ''
    xset r rate 225 30
    brightnessctl set 100%
    autorandr -c
  '';
  home.file.".XCompose".source = ./XCompose;
}
