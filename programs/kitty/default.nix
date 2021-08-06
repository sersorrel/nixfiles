{ ... }:

{
  programs.kitty.enable = true;
  programs.kitty.extraConfig = builtins.readFile ./kitty.conf;
  home.file.".config/kitty/open-actions.conf".source = ./open-actions.conf;
  home.file.".config/kitty/hyperlinked_rg.py".source = ./hyperlinked_rg.py;
  home.file.".config/kitty/hyperlinked_fd.py".source = ./hyperlinked_fd.py;
  home.sessionVariables.TERMINAL = "kitty";
}
