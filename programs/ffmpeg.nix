{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # there must be a better way to do this, but passing the rtmpdump derivation to elem doesn't seem to work...
    (assert builtins.elem "rtmpdump" (map (p: p.pname or null) ffmpeg-full.buildInputs); ffmpeg-full.override {
      # https://github.com/NixOS/nixpkgs/issues/142260
      rtmpdump = null;
    })
  ];
}
