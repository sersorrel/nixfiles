{ pkgs, ... }:

{
  allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "discord"
    "insync"
    "slack"
    "todoist-electron"
  ];
  packageOverrides = pkgs: {
    vim_configured = pkgs.vim_configurable.customize {
      name = "vim";
      wrapGui = true;
      vimrcConfig.packages.pkgs = with pkgs.vimPlugins; {
        start = [
          vim-sensible
        ];
      };
    };
  };
}
