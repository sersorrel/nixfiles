{ pkgs, ... }:

{
  home.packages = with pkgs; [ slack ];
  programs.i3.extraConfig = [ ''assign [class="^Slack$"] workspace number 3'' ];
}
