{ ... }:

{
  programs.kitty.enable = true;
  programs.kitty.extraConfig = builtins.readFile ./kitty.conf;
  xdg.configFile."kitty/open-actions.conf".source = ./open-actions.conf;
  xdg.configFile."kitty/hyperlinked_rg.py".source = ./hyperlinked_rg.py;
  xdg.configFile."kitty/hyperlinked_fd.py".source = ./hyperlinked_fd.py;
  home.sessionVariables.TERMINAL = "kitty";
}
