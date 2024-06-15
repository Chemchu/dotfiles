{
  config,
  pkgs,
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
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    # OpenGl
    opengl.enable = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
    opengl.extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];

    nvidia = {
      # Most wayland compositors need this
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      nvidiaSettings = true;

      open = false;

      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
}
