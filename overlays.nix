[
  (self: super: let unstable = import <nixos-unstable> { overlays = []; }; in {
    kitty = assert builtins.compareVersions super.kitty.version "0.24.0" == -1; unstable.kitty;
    flameshot = assert builtins.compareVersions super.flameshot.version "11.0.0" == -1; unstable.flameshot;
    rust-analyzer = unstable.rust-analyzer; # required to work properly with new Cargo versions
  })
  # https://github.com/flameshot-org/flameshot/issues/2302
  (self: super: {
    flameshot = assert builtins.compareVersions super.flameshot.version "11.0.0" == 0; super.flameshot.overrideAttrs (old: {
      version = "unstable-2022-02-18";
      src = super.fetchFromGitHub {
        owner = "flameshot-org";
        repo = "flameshot";
        rev = "aa6b5eac93ee92b58c5ead9404f60a760f667980";
        sha256 = "0dckspmzyakn68r84j58njl73n5k662d0p6517v5jmwcqm3qrrkm";
      };
    });
  })
  (self: super: {
    todoist-electron = super.todoist-electron.override {
      electron = super.electron_15;
    };
  })
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
  (self: super: {
    rhythmbox = super.rhythmbox.overrideAttrs (old: {
      patches = (old.patches or []) ++ [
        ./patches/rhythmbox-0001-no-pause-notification.patch
      ];
    });
  })
]
