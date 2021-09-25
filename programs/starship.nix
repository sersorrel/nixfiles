{ lib, pkgs, ... }:

let
  unstable = import <nixos-unstable> { overlays = import ../overlays.nix; };
  esc = builtins.fromJSON ''"\u001B"'';
in
{
  programs.starship = {
    enable = true;
    package = assert builtins.compareVersions pkgs.starship.version "0.58.0" == -1; unstable.starship; # $all deduplication, https://github.com/starship/starship/pull/3026
    settings = {
      battery = {
        disabled = true;
      };
      character = {
        success_symbol = ''[\$](bold green)'';
        error_symbol = ''[\$](bold red)'';
        vicmd_symbol = ''[£](bold green)'';
      };
      directory = {
        truncation_length = 7;
        truncate_to_repo = false;
        truncation_symbol = "…/";
        read_only = " 🔒";
        read_only_style = "";
        format = "in [$path]($style)[$read_only]($read_only_style) ";
      };
      git_branch = {
        only_attached = true;
      };
      git_commit = {
        only_detached = false;
        tag_disabled = false;
      };
      git_status = {
        untracked = "!";
        modified = "~";
        conflicted = "|||";
        ahead = ">";
        behind = "<";
        diverged = "<>";
      };
      hostname = {
        format = "on [$hostname]($style) ";
      };
      jobs = {
        threshold = 1;
        symbol = "✦ ";
      };
      shlvl = {
        disabled = false;
        symbol = "↕️ ";
        threshold = 3;
      };
      status = {
        disabled = false;
        symbol = "";
      };
      username = {
        format = "[$user]($style) ";
      };
      format = lib.concatStrings [
        "🦉 "
        "$all" # automatically excludes modules we position explicitly
        ''${esc}\[48;2;242;229;188m${esc}\[K$line_break${esc}\[49m''
        "$jobs"
        "$battery"
        "$time"
        "$status"
        "$shell"
        "$character"
      ];
    };
  };
}
