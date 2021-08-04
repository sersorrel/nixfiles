{ pkgs, ... }:

{
  allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "insync"
    "slack"
    "todoist-electron"
  ];
}
