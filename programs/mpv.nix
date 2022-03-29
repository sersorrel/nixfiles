{ ... }:

{
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "gpu-hq" ];
    config = {
      keep-open = true;
      osd-on-seek = false;
    };
    # TODO: mute on step forwards: https://github.com/mpv-player/mpv/issues/6104
  };
}
