{ config, lib, ... }:

let
  unstable = import <nixos-unstable> {};
in
{
  options = {
    programs.i3.extraConfig = lib.mkOption {
      type = with lib.types; listOf string;
      default = [];
      description = ''
        Additional lines of configuration to append to the i3 config file.
      '';
    };
  };

  config = {
    home.file.".config/i3/config".text = (builtins.readFile ./config) + "\n" + lib.strings.concatStringsSep "\n" config.programs.i3.extraConfig;
    home.file.".config/rofi/config.rasi".text = ''
      configuration {
        theme: "gruvbox-dark";
        show-icons: true;
        icon-theme: "Paper";
        modi: "window,run,ssh,drun";
        monitor: "-1";
        drun-match-fields: "name";
        tokenize: true;
        sort: true;
        sorting-method: "fzf";
        matching: "fuzzy";
      }
      // Hide the colon at the start of the textbox.
      textbox-prompt-sep {
        enabled: false;
      }
      // Make the application icons a reasonable size.
      element-icon {
        size: 1.2em;
      }
    '';
    programs.i3status-rust = {
      enable = true;
      package = unstable.i3status-rust;
      bars.default = {
        settings = {
          theme = {
            name = "gruvbox-light";
            overrides = {
              idle_bg = "#FFFFFF88";
              info_bg = "#FFFFFF88";
              good_bg = "#FFFFFF88";
              info_fg = "#3C3836FF";
              good_fg = "#3C3836FF";
              alternating_tint_bg = "#00000000";
              warning_fg = "#FBF1C7FF";
              separator = "";
            };
          };
          icons = {
            name = "awesome";
            overrides = {
              time = builtins.fromJSON ''"\uF133"'';
              net_wired = builtins.fromJSON ''"\uF0AC"'';
              net_wireless = builtins.fromJSON ''"\uF1EB"'';
              phone_disconnected = builtins.fromJSON ''"\uF10B"'';
            };
          };
        };
        blocks = [
          # TODO: dunst disabled, mic muted, E:D time
          {
            block = "disk_space";
            format = builtins.fromJSON ''"\uF15B"'' + " {available:1; M}";
            path = "/nix";
            warning = 10;
            alert = 5;
          }
          {
            block = "disk_space";
            format = builtins.fromJSON ''"\uF0A0"'' + " {available:1; M}";
            path = "/persist";
            warning = 10;
            alert = 5;
          }
          {
            block = "disk_space";
            format = builtins.fromJSON ''"\uF2ED"'' + " {available:1; M}";
            path = "/";
            warning = 10;
            alert = 5;
          }
          {
            block = "net";
            device = "wlp3s0";
            format = "";
          }
          {
            block = "net";
            device = "enp4s0f1";
            format = "";
          }
          # TODO: bluetooth
          {
            block = "memory";
            clickable = false;
            format_mem = "{mem_used:1;_G*_}/{mem_total:1;_G*_}";
            warning_mem = 90;
          }
          {
            block = "memory";
            display_type = "swap";
            clickable = false;
            format_swap = "{swap_used:1;_G*_}/{swap_total:1;_G*_}";
            warning_swap = 50;
          }
          # TODO: Nvidia VRAM usage, picom state
          {
            block = "battery";
            format = "{percentage:1} {time} {power:1}";
            driver = "upower";
          }
          {
            block = "kdeconnect";
            format = "{bat_charge:1}";
            format_disconnected = "";
            bat_warning = 20;
            bat_critical = 10;
          }
          {
            block = "temperature";
            chip = "coretemp-isa-0000";
            collapsed = false;
            format = "{average}";
            idle = 80;
            info = 90;
            warning = 100;
          }
          {
            block = "uptime";
          }
          # TODO: next-lecture?
          {
            block = "time";
            format = "%A %F %-I:%M %P";
          }
        ];
      };
    };
  };
}
