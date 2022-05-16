{ ... }:

{
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "gpu-hq" ];
    config = {
      keep-open = true;
      osd-on-seek = false;
    };
    bindings = {
      HOME = "seek 0 absolute+exact";
      END = "seek 100 absolute-percent+exact";
    };
    # TODO: mute on step forwards: https://github.com/mpv-player/mpv/issues/6104
  };
}
