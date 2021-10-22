{ config, pkgs, ... }:

{
  home.sessionVariables.NIX_SCRIPT_CACHE_PATH = "${config.xdg.cacheHome}/nix-script";
  home.packages = with pkgs; [
    (
      import (
        fetchFromGitHub {
          owner = "BrianHicks";
          repo = "nix-script";
          rev = "2ebbfa6bf727c6c4ccda522e643f689b9301ba2c"; # TODO: newer commits don't appear to work properly
          sha256 = "1s2a1dx9v5ss1x0mjm821nzja8n1xpjac4801fvlraw6fyjif6zh";
        }
      ) {}
    )
  ];
}
