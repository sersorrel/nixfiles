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

  # Override various parts of the detected hardware configuration.
  fileSystems."/".options = [ "defaults" "size=8G" "mode=755" ];
  fileSystems."/persist".neededForBoot = true;

  # Enable periodic TRIM (by default once per week).
  services.fstrim.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure the machine's hostname and timezone.
  networking.hostName = "the";
  time.timeZone = "Europe/London";

  # Use wpa_supplicant for WiFi.
  networking.wireless.enable = true;
  networking.wireless.driver = "nl80211,wext";
  networking.wireless.interfaces = [ "wlp3s0" ];
  networking.wireless.networks = config.secrets.wifi;

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

  # Enable UPower, mostly so that applications can get the battery level.
  services.upower.enable = true;

  # Let applications store settings in dconf.
  programs.dconf.enable = true;
  services.dbus.packages = with pkgs; [ gnome.dconf ];

  # Make nautilus happy.
  services.gvfs.enable = true;

  # Set up the i3 window manager and LightDM display manager.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.desktopManager.xfce.enable = false;
  services.xserver.desktopManager.wallpaper.mode = "fill";
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    i3status-rust
    rofi
  ];

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
    # Avoid showing the background when switching workspace.
    # https://github.com/yshui/picom/issues/16#issuecomment-792739119
    fade = true;
    fadeDelta = 30;
    fadeSteps = [1.0 1.0];
  };

  # Configure keymap in X11.
  services.xserver.layout = "gb-qw0rty";
  services.xserver.xkbOptions = "compose:caps,altwin:swap_lalt_lwin";
  services.xserver.extraLayouts.gb-qw0rty = {
    description = "English (UK) (qw0rty)";
    languages = [ "eng" ];
    symbolsFile = ./qw0rty/symbols/gb-qw0rty;
  };
  # Try to use a similar keymap in the console.
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Support use of the Fish shell.
  programs.fish.enable = true;
  # Don't clobber users' shell functions!
  environment.shellAliases = {
    l = null;
    ll = null;
    ls = null;
  };

  # Do not allow /etc/passwd and /etc/group to be changed e.g. with useradd(8).
  users.mutableUsers = false;
  # Define a user account.
  users.users.ash = {
    isNormalUser = true;
    extraGroups = [
      "colord" # Allow access to monitor calibration devices.
      "wheel" # Enable ‘sudo’ for the user.
    ];
    initialPassword = config.secrets.password;
    shell = pkgs.fish;
  };

  # Currently ~/.profile isn't sourced in graphical sessions, let's fix that.
  # https://github.com/NixOS/nixpkgs/issues/5200
  environment.loginShellInit = ''
    if test -f ~/.profile; then
      . ~/.profile
    fi
  '';

  # Persist the machine ID across reboots.
  environment.etc."machine-id".source = "/persist/etc/machine-id";
  systemd.tmpfiles.rules = [
    # Save some randomness across reboots (or attempt to).
    # TODO: does this run early enough to be useful?
    "L /var/lib/systemd/random-seed - - - - /persist/var/lib/systemd/random-seed"
  ];

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
    ];
    permittedInsecurePackages = [
      # Required for displaycal, https://github.com/NixOS/nixpkgs/issues/124590
      "python2.7-Pillow-6.2.2"
    ];
  };
  # Install some packages system-wide.
  environment.systemPackages = with pkgs; [
    vim # The Nano editor is also installed by default.
    wget
    firefox
    pavucontrol
    google-chrome
    ncdu
    git
    github-cli
    file
    pciutils
    nvtop
    nvidia-offload # defined above
    gnome.nautilus
    gnome.file-roller
    gnome.eog
    glimpse
    # dependency required for glimpse
    graphviz
    displaycal
  ];

  # Make Steam Work™.
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  # Attempt to permit colour management.
  services.colord.enable = true;

  # Suspend on lid close, even when an external monitor is plugged in.
  services.logind.lidSwitchDocked = "suspend";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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

