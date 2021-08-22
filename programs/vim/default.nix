{ pkgs, ... }:

{
  home.sessionVariables.EDITOR = "vim";
  home.packages = with pkgs; [
    vim_configured
  ];
}
