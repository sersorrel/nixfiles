{ pkgs, ... }:

let
  removeAttrs = attrs: pkgs.lib.attrsets.filterAttrs (attr: _: builtins.all (x: attr != x) attrs);
  vim_config = removeAttrs ["override" "overrideDerivation" "overrideAttrs"] (pkgs.callPackage ./programs/vim/vim.nix {});
in
{
  allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "discord"
    "insync"
    "obsidian"
    "slack"
    "steam"
    "steam-original"
    "steam-runtime"
    "talon"
    "talon-beta"
    "todoist-electron"
    "zoom"
  ];
  packageOverrides = pkgs: {
    vim_configured = pkgs.vim_configurable.customize vim_config;
  };
  permittedInsecurePackages = [
    "electron-13.6.9" # for obsidian < 0.13.24, https://github.com/NixOS/nixpkgs/issues/158956
  ];
}
