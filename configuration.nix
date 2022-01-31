# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" -- "$@"
  '';
in
{
  imports = [
    ./hardware-configuration.nix
    ./secrets
  ];

  nixpkgs.overlays = [
    (self: super: {
      picom = super.picom.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          owner = "yshui";
          repo = "picom";
          rev = "78e8666498490ae25349a44f156d0811b30abb70";
          sha256 = "0lx30w9ccrivnm05i1m67wvhkiw166i8v0gdj6ql6jganrwnwzwk";
          fetchSubmodules = true;
        };
      });
    })
    (self: super: {
      i3lock-color = super.i3lock-color.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          owner = "sersorrel";
          repo = "i3lock-color";
          rev = "8ab09b8d3fdd87ac0b14a3f419281a4791fa2c78";
          sha256 = "1l25x4wx3ar6lfpxcm5whzpxyblcs8blf4gqi3vh2ynvn7cn1qib";
        };
      });
    })
    (self: super: {
      gnome = super.gnome.overrideScope' (self': super': {
        totem = super'.totem.overrideAttrs (old: {
          patches = (old.patches or []) ++ [
            ./patches/totem-0001-seek-length.patch
          ];
        });
        gnome-power-manager = super'.gnome-power-manager.overrideAttrs (old: {
          patches = (old.patches or []) ++ [
            ./patches/gnome-power-manager-0001-desktop-entry.patch
          ];
        });
      });
      i3status-rust = super.i3status-rust.overrideAttrs (old: {
        patches = (old.patches or []) ++ [
          ./patches/i3status-rust-0001-uptime-warning.patch
        ];
      });
      i3 = super.i3.overrideAttrs (old: {
        patches = (old.patches or []) ++ [
          ./patches/i3-0001-i3bar-border.patch
        ];
      });
    })
    (self: super: {
      # https://github.com/NixOS/nixpkgs/pull/127289
      # specifically: "Support OSC 8 hyperlinks when -R is in effect."
      less = super.less.overrideAttrs (old: rec {
        version = "581.2";
        src = pkgs.fetchurl {
          url = "https://www.greenwoodsoftware.com/less/less-${version}.tar.gz";
          sha256 = "0fyqslvrasv19qjvqrwfwz2n7mnm93y61x9bcx09ga90mxyb8d6f";
        };
      });
    })
  ];

  # Override various parts of the detected hardware configuration.
  fileSystems."/".options = [ "defaults" "size=8G" "mode=755" ];
  fileSystems."/persist".neededForBoot = true;

  # Enable periodic TRIM (by default once per week).
  services.fstrim.enable = true;
  # Empty /tmp on boot.
  boot.cleanTmpDir = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Disable SMT/hyperthreading.
  security.allowSimultaneousMultithreading = false;

  # Enable Switch controller support (pro controller, joycons).
  boot.extraModulePackages = with config.boot.kernelPackages; [ hid-nintendo ];
  services.joycond.enable = true;

  # Configure the machine's hostname and timezone.
  networking.hostName = "the";
  time.timeZone = "Europe/London";

  # For any individual build, don't use all cores.
  nix.buildCores = 2;
  # Don't build too many derivations in parallel.
  nix.maxJobs = 3;
  # It would be nice to be able to limit the product of those rather than the individual coefficients, but hey.

  # Use NetworkManager for WiFi.
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0f1.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Use the proprietary NVIDIA driver.
  services.xserver.videoDrivers = [ "nvidia" ];
  # Despite my GPU appearing to be muxful, that alone doesn't work, so we use PRIME offloading too.
  hardware.nvidia.prime = {
    offload.enable = true;
    # These are identical to the wiki's example, but they're also correct for my system.
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  # Make suspend a little more fragile but a little less likely to break things,
  # by using system memory to actually persist all of VRAM.
  hardware.nvidia.powerManagement.enable = true;

  # Enable Bluetooth support.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Use updated microcode when available.
  hardware.cpu.intel.updateMicrocode = true;

  # Enable UPower, mostly so that applications can get the battery level.
  services.upower.enable = true;

  # Let applications store settings in dconf.
  programs.dconf.enable = true;
  services.dbus.packages = with pkgs; [ gnome.dconf ];

  # Make nautilus/nemo happy.
  services.gvfs.enable = true;

  # Let Gnome Tracker index files (required for e.g. Gnome Music to work).
  services.gnome.tracker.enable = true;
  services.gnome.tracker-miners.enable = true;

  services.mullvad-vpn.enable = true;
  networking.firewall.checkReversePath = "loose"; # https://github.com/NixOS/nixpkgs/pull/121906

  # Enable Samba, and allow SMBv1.
  services.samba.enable = true;
  services.samba.extraConfig = ''
    client min protocol = NT1
  '';

  # Set up the i3 window manager and LightDM display manager.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.desktopManager.xfce.enable = false;
  services.xserver.desktopManager.wallpaper.mode = "fill";
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    i3status-rust
    rofi
    i3lock-color
  ];
  # Start XDG-compliant autostart things when using i3.
  # based on https://github.com/NixOS/nixpkgs/pull/127367
  systemd.user.targets.i3-xdg-autostart = {
    description = "Run XDG autostart files for i3";
    wants = [ "xdg-desktop-autostart.target" ];
    after = [ "graphical-session.target" "xdg-desktop-autostart.target" ];
    bindsTo = [ "graphical-session.target" ];
  };
  services.xserver.windowManager.i3.extraSessionCommands = "/run/current-system/systemd/bin/systemctl --user start i3-xdg-autostart.target";
  # Propagate variables like $DISPLAY to applications activated via D-Bus.
  services.xserver.updateDbusEnvironment = true;
  # Set some reasonable defaults for key repeat rate, used if a keyboard is hotplugged after login.
  # See programs/x/default.nix: `xset r rate 225 30`
  # TODO: consider factoring these out to avoid duplication.
  services.xserver.autoRepeatDelay = 225;
  services.xserver.autoRepeatInterval = 1000 / 30;

  # Enable a compositor.
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    shadow = true;
    shadowExclude = [
      "class_g = 'i3-frame'"
      "class_g = 'i3bar'"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'" # windows in unselected tabs
    ];
    settings.xinerama-shadow-crop = true;
    # Fix flickering after DPMS off.
    # https://github.com/yshui/picom/issues/268
    settings.use-damage = false;
    # Avoid showing the background when switching workspace.
    # https://github.com/yshui/picom/issues/16#issuecomment-792739119
    fade = true;
    fadeDelta = 30;
    fadeSteps = [1.0 1.0];
  };

  # Configure keymap in X11.
  # https://twitter.com/mycoliza/status/1161307160254410753
  services.xserver.layout = "gb-qw0rty";
  services.xserver.xkbOptions = "caps:super,altwin:swap_lalt_lwin,lv3:ralt_switch_multikey";
  services.xserver.extraLayouts.gb-qw0rty = {
    description = "English (UK) (qw0rty)";
    languages = [ "eng" ];
    symbolsFile = ./qw0rty/symbols/gb-qw0rty;
  };
  # Try to use a similar keymap in the console.
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    brlaser
    brgenml1lpr
    brgenml1cupswrapper
  ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # Disable HSP (since we don't have oFono): https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1149
  hardware.pulseaudio.extraConfig = ''
    .ifexists module-bluetooth-discover.so
    unload-module module-bluetooth-discover
    load-module module-bluetooth-discover headset=ofono
    .endif
  '';

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  # Make the trackpad scroll the correct way.
  services.xserver.libinput.touchpad.naturalScrolling = true;

  # Support use of the Fish shell.
  programs.fish.enable = true;
  # Don't clobber users' shell functions!
  environment.shellAliases = {
    l = null;
    ll = null;
    ls = null;
  };

  environment.variables = {
    LADSPA_PATH = "/run/current-system/sw/lib/ladspa";
  };

  # Do not allow /etc/passwd and /etc/group to be changed e.g. with useradd(8).
  users.mutableUsers = false;
  # Define a user account.
  users.users.ash = {
    isNormalUser = true;
    extraGroups = [
      "colord" # Allow access to monitor calibration devices.
      "wheel" # Enable ‘sudo’ for the user.
      "adbusers" # Allow use of adb.
      "networkmanager" # Allow network configuration.
    ];
    shell = pkgs.fish;
  } // config.secrets.userOptions;

  # Currently ~/.profile isn't sourced in graphical sessions, let's fix that.
  # https://github.com/NixOS/nixpkgs/issues/5200
  environment.loginShellInit = ''
    if test -f ~/.profile; then
      . ~/.profile
    fi
  '';

  # Persist the machine ID across reboots.
  environment.etc."machine-id".source = "/persist/etc/machine-id";

  nixpkgs.config = {
    # Allow installation of listed non-free packages.
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "google-chrome"
      "nvidia-settings"
      "nvidia-x11"
      "cudatoolkit" # for nvtop
      "steam"
      "steam-original"
      "steam-runtime"
      "brgenml1lpr"
    ];
    permittedInsecurePackages = [
      # Required for displaycal, https://github.com/NixOS/nixpkgs/issues/124590
      # "python2.7-Pillow-6.2.2"
    ];
  };
  # Install some packages system-wide.
  environment.systemPackages = with pkgs; [
    vim # The Nano editor is also installed by default.
    wget
    pavucontrol
    google-chrome
    ncdu
    borgbackup
    git
    github-cli
    file
    pciutils
    nvtop
    nvidia-offload # defined above
    polkit_gnome
    gnome.adwaita-icon-theme
    gnome.cheese
    gnome.file-roller
    gnome.eog
    gnome.totem
    gnome.gnome-system-monitor
    gnome.gnome-power-manager
    gnome.gnome-boxes
    gnome.networkmanagerapplet
    glimpse
    gparted
    # dependency required for glimpse
    graphviz
    # displaycal
    gcc
    man-pages
    man-pages-posix
    mullvad-vpn
    ladspaPlugins
  ];

  # Install more manual pages.
  documentation.dev.enable = true;

  # Make Steam Work™.
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  # Attempt to permit colour management.
  services.colord.enable = true;

  # Suspend on lid close, even when an external monitor is plugged in.
  services.logind.lidSwitchDocked = "suspend";

  programs.adb.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable Avahi (i.e. mDNS support).
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.autorandr.enable = true;

  # Backups
  services.borgbackup.jobs = {
    persist = {
      paths = [ "/persist" ];
      repo = "/media/Az/shared/borg/the";
      doInit = false;
      removableDevice = true;
      # This doesn't work, since the job can't run unless the drive is mounted (see systemd ReadWritePaths).
      # If the path was made optional, it wouldn't have write permissions to it once it was mounted.
      # preHook = ''
      #   ${pkgs.glib}/bin/gio mount -d 6c2e615b-73e4-40c5-99ae-253fc2c506da
      # '';
      encryption = {
        mode = "repokey";
        passCommand = "cat /var/secrets/borg-az-the.key";
      };
      compression = "zstd";
      prune = {
        keep = {
          within = "1y";
        };
      };
      startAt = "13:00:00";
    };
  };

  systemd.tmpfiles.rules = [
    # Create and clean /media (much like /run).
    "D /media 0755 root root 0 -"
  ];

  services.udev.extraRules = ''
    # Mount Az in /media rather than in /run/media/$USER.
    ENV{ID_FS_UUID}=="6c2e615b-73e4-40c5-99ae-253fc2c506da", ENV{UDISKS_FILESYSTEM_SHARED}="1"
  '';

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.allowedTCPPortRanges = [
    { from = 1714; to = 1764; } # KDE Connect
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; } # KDE Connect
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

