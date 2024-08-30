  {
    # Define your filesystems here
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/3db698b6-f625-4629-8b09-1ce9dbd6ae68";
        fsType = "ext4";
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/058B-CAE4";
        fsType = "vfat";
      };
      "/mnt/lvm" = {
        device = "/dev/mapper/vg_nixos-lv_nixos";
        fsType = "ext4";
      };
    };

    swapDevices = [
      {
        device = "/dev/disk/by-uuid/8eb27adc-ed5e-4c3b-bc97-fa4abc4c73f1";
      }
    ];
  }
