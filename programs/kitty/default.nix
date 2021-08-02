{ ... }:

{
  programs.kitty.enable = true;
  programs.kitty.extraConfig = builtins.readFile ./kitty.conf;
  home.file.".config/kitty/open-actions.conf".source = ./open-actions.conf;
  home.sessionVariables.TERMINAL = "kitty";
}
