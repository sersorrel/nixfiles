{ ... }:

{
  programs.bat = {
    enable = true;
    config = {
      italic-text = "always";
      # pager = "some";
      style = "numbers,changes";
      theme = "gruvbox-light";
    };
  };
}
