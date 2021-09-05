{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
  ];
  home.sessionVariables.RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/config";
  xdg.configFile."ripgrep/config".text = ''
    --smart-case
    --max-columns
    1000
    --max-columns-preview
    --multiline-dotall
    --type-add
    cfg:*.cfg
  '';
}
