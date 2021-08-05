{ lib, ... }:

let
  esc = builtins.fromJSON ''"\u001B"'';
in
{
  programs.starship = {
    enable = true;
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
        "$username"
        "$hostname"
        "$shlvl"
        "$kubernetes"
        "$directory"
        "$vcsh"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$hg_branch"
        "$docker_context"
        "$package"
        "$cmake"
        "$dart"
        "$deno"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$golang"
        "$helm"
        "$java"
        "$julia"
        "$kotlin"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$perl"
        "$php"
        "$purescript"
        "$python"
        "$red"
        "$ruby"
        "$rust"
        "$scala"
        "$swift"
        "$terraform"
        "$vlang"
        "$vagrant"
        "$zig"
        "$nix_shell"
        "$conda"
        "$memory_usage"
        "$aws"
        "$gcloud"
        "$openstack"
        "$env_var"
        "$crystal"
        "$custom"
        "$cmd_duration"
        ''${esc}\[48;2;242;229;188m${esc}\[K$line_break${esc}\[49m''
        "$lua"
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
