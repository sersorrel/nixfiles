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
    paper-gtk-theme = super.paper-gtk-theme.overrideAttrs (old: {
      src = super.fetchFromGitHub {
        owner = "hugogoncalves77";
        repo = "paper-gtk-theme";
        rev = "5a81820bdc5258855b7cd98377f377977a35cf41";
        sha256 = "087nxz196wclrsdxq3mzqjg2p8sq9w92rj1brfhxspfkzy1y39i1";
      };
    });
  })
]
