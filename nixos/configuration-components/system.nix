{
  config,
  pkgs,
  system_name,
  ...
}
:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Nvidia stuff
  services.xserver.videoDrivers = if system_name == "spaceship" then
    ["nvidia"]
  else if system_name == "framework" then
    ["amdgpu"]
  else
    [];

  hardware= {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    nvidia = if system_name == "spaceship" then {
      # Most wayland compositors need this
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      nvidiaSettings = true;

      open = false;

      package = config.boot.kernelPackages.nvidiaPackages.latest;
    } else {};
  };
}
