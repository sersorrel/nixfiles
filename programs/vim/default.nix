{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vim_configured
  ];
  xdg.dataFile."applications/vim.desktop".text = ''
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
