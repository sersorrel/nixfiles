{ pkgs, ... }:

let
  removeAttrs = attrs: pkgs.lib.attrsets.filterAttrs (attr: _: builtins.all (x: attr != x) attrs);
  vim_config = removeAttrs ["override" "overrideDerivation" "overrideAttrs"] (pkgs.callPackage ./programs/vim/vim.nix {});
in
{
  allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "discord"
    "insync"
    "slack"
    "talon"
    "talon-beta"
    "todoist-electron"
  ];
  packageOverrides = pkgs: {
    vim_configured = pkgs.vim_configurable.customize vim_config;
  };
}
