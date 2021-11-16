[
  (self: super: {
    kitty = super.kitty.overrideAttrs (old: {
      patches = (old.patches or []) ++ [
        ./patches/kitty-0001-sound-theme.patch
      ];
    });
  })
  (self: super: {
    some = super.rustPlatform.buildRustPackage {
      pname = "some";
      version = "0.1.0";
      src = super.fetchFromGitHub {
        owner = "sersorrel";
        repo = "some.rs";
        rev = "1e24bff9b2b8ef09ea69d82f40a3da6b07dc1d38";
        sha256 = "17z113zka3id1s7p59rq54y2whk9ah3pbnyazhm9x7lzq34d02va";
      };
      cargoSha256 = "0706n3939aqz1h5b3g1ipdni29nsbwyiycna2qhns6dwxj6fm9sk";
      meta = with super.lib; {
        description = "a meta-pager";
        homepage = "https://github.com/sersorrel/some.rs";
      };
    };
  })
  (self: super: {
    uoyweek = super.rustPlatform.buildRustPackage {
      pname = "uoyweek";
      version = "0.1.0";
      src = super.fetchFromGitHub {
        owner = "sersorrel";
        repo = "uoyweek.rs";
        rev = "d32e4096dee51641270cb4b624d7b0727f101f42";
        sha256 = "17a2173myj6fxmgyaly6nz905b94vw6zr8qm5v2ig7yrxlqd9nnk";
      };
      cargoSha256 = "1xfgszxbj1ji0wpz01n9hhwnba7kxbbqk53r0sgxasxbzfmmknw5";
    };
  })
  (self: super: {
    talon = super.callPackage ./programs/talon/talon.nix {};
    talon-beta = super.callPackage ./programs/talon/talon-beta.nix {
      srcs = (import ./secrets/secrets.nix { inherit (super) lib; }).secrets.talon-beta;
    };
  })
  (self: super: {
    rcu = super.callPackage ./programs/rcu/rcu.nix {
      srcs = (import ./secrets/secrets.nix { inherit (super) lib; }).secrets.rcu;
    };
  })
  (self: super: {
    display-volume = super.rustPlatform.buildRustPackage {
      pname = "display-volume";
      version = "0.1.0";
      src = super.fetchFromGitHub {
        owner = "sersorrel";
        repo = "display-volume";
        rev = "318a70933869d3a5c50bce06bda2887c3c287e84";
        sha256 = "1gqyxggxwk87ddcsisb4s1rw8f9z8lyxg95py0nn77q18w6f6srg";
      };
      cargoSha256 = "1a8rm1hnw7gmbvaps9p0kcr3v0vm7a0ax31qcfsghhl3nckr4nkm";
      nativeBuildInputs = [
        super.autoPatchelfHook
      ];
      buildInputs = [
        super.libpulseaudio
      ];
    };
  })
  (self: super: {
    file2img = super.callPackage ./programs/file2img/file2img.nix {};
  })
  (self: super: { # https://trac.ffmpeg.org/ticket/7547
    ffmpeg-full = super.ffmpeg-full.override {
      rtmpdump = null;
    };
  })
  (self: super: {
    rhythmbox = super.rhythmbox.overrideAttrs (old: {
      patches = (old.patches or []) ++ [
        ./patches/rhythmbox-0001-no-pause-notification.patch
      ];
    });
  })
  # https://github.com/NixOS/nixpkgs/issues/145840
  (self: super: {
    paper-icon-theme = assert super.paper-icon-theme.version == "2018-06-24"; super.paper-icon-theme.overrideAttrs (old: {
      version = "2020-03-12";
      src = super.fetchFromGitHub {
        owner = "snwh";
        repo = "paper-icon-theme";
        rev = "aa3e8af7a1f0831a51fd7e638a4acb077a1e5188";
        sha256 = "0x6qzch4rrc8firb1dcf926j93gpqxvd7h6dj5wwczxbvxi5bd77";
      };
    });
  })
]
