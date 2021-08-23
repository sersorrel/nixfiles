{ pkgs, ... }:

let
  dunst-notify = pkgs.writeShellScriptBin "dunst-notify" ''
    appname=$1
    summary=$2
    body=$3
    icon=$4
    urgency=$5 # LOW, NORMAL, or CRITICAL
    case "$appname" in
      Slack)
        ${pkgs.pulseaudio}/bin/paplay --volume 45000 ${toString ../secrets/slack-ping.ogg}
        ;;
    esac
  '';
in
{
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };
    settings = {
      global = {
        monitor = 1;
        geometry = "300x5-30+30";
        padding = 16;
        horizontal_padding = 16;
        frame_color = "#aaaaaa";
        separator_color = "frame";
        idle_threshold = 600;
        font = "Source Sans Variable 12";
        markup = "full";
        format = "%a: <b>%s</b>\\n%b";
        show_age_threshold = 60;
        word_wrap = true;
        icon_position = "left";
        max_icon_size = 24;
        corner_radius = 4;
        dmenu_path = "/run/current-system/sw/bin/rofi -dmenu -p ''";
        browser = "/run/current-system/sw/bin/google-chrome-stable";
        mouse_left_click = "do_action";
        mouse_middle_click = "close_current";
        mouse_right_click = "close_current";
      };
      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
      };
      urgency_low = {
        background = "#ffffff";
        foreground = "#000000";
        highlight = "#ec008c";
        timeout = 7;
      };
      urgency_normal = {
        background = "#ffffff";
        foreground = "#000000";
        highlight = "#ec008c";
        timeout = 7;
      };
      urgency_critical = {
        background = "#ffffff";
        foreground = "#000000";
        highlight = "#ec008c";
        timeout = 0;
      };
      rule_slack = {
        appname = "Slack";
        script = "${dunst-notify}/bin/dunst-notify";
      };
    };
  };
}