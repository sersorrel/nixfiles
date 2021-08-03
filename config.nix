{ pkgs, ... }:

{
  allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "todoist-electron"
  ];
}
