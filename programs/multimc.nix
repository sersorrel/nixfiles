{ pkgs, ...}:

{
  home.packages = with pkgs; [
    multimc
  ];
}
