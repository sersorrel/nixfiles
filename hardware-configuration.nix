# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2509-5FDA";
      fsType = "vfat";
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/1d98672f-f569-4b8a-8485-678e133817f8";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."slow_crypt".device = "/dev/disk/by-uuid/d7d68e21-5b1e-4962-a636-4bf84da30975";

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/1fc1341b-5386-43c2-aacf-8a51260348cc";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."fast_crypt".device = "/dev/disk/by-uuid/787b1ca4-1ba9-4729-a4dd-1cc8b072991c";

  fileSystems."/etc/nixos" =
    { device = "/persist/etc/nixos";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/log" =
    { device = "/persist/var/log";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/db/sudo/lectured" =
    { device = "/persist/var/db/sudo/lectured";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/lib/bluetooth" =
    { device = "/persist/var/lib/bluetooth";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/lib/colord" =
    { device = "/persist/var/lib/colord";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/lib/systemd/coredump" =
    { device = "/persist/var/lib/systemd/coredump";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/lib/upower" =
    { device = "/persist/var/lib/upower";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/home" =
    { device = "/persist/home";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/tmp" =
    { device = "/nix/tmp";
      fsType = "none";
      options = [ "bind" ];
    };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
