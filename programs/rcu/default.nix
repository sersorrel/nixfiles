{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rcu
  ];
}
