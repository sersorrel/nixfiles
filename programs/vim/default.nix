{ pkgs, ... }:

{
  home.sessionVariables.EDITOR = "vim";
  home.packages = with pkgs; [
    vim_configured
  ];
  home.file.".local/share/applications/vim.desktop".text = ''
    [Desktop Entry]
    Name=Vim
    Icon=vim
    Type=Application
    Exec=${pkgs.vim_configured}/bin/gvim -f %F
    Terminal=false
    StartupNotify=true
    MimeType=text/*;
  '';
}
