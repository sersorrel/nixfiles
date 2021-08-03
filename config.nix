{ pkgs, ... }:

{
  allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "insync"
    "todoist-electron"
  ];
}
