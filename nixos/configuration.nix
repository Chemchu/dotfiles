# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  system_name,
  config_path,
  lib,
  ...
}: let
  hardware-configuration = ./${system_name}-hardware-configuration.nix;
in {
  imports =
    [
      # Include the results of the hardware scan.
      inputs.home-manager.nixosModules.default
      hardware-configuration
      ./configuration-components/environment-variables.nix
      ./configuration-components/flatpak.nix # Only installing this to avoid building electron from source
      ./configuration-components/flipperzero.nix
      ./configuration-components/ld.nix # --> Removed by now. I need to test using flakes for repositories
      ./configuration-components/locale.nix
      ./configuration-components/sound.nix
      ./configuration-components/system.nix
      ./configuration-components/bluetooth.nix
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gus = {
    isNormalUser = true;
    description = "gus";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "wireshark"
    ];
  };

  services = {
    # Enable automatic login for the user.
    getty.autologinUser = "gus";
    # Enable locate file finder
    locate.enable = true;

    tlp = {
      enable = false;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "powersave";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 70;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 70;
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    kitty
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    glxinfo
  ];

  fonts.packages =
    builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
  };

  programs.java.enable = true;

  # Enable Hyprland
  programs.hyprland.enable = true;

  programs.wireshark = {
    enable = true;
    usbmon.enable = true;
  };

  # Swaylock not getting password correctly fix
  # security.pam.services.swaylock = {};

  # Home-Manager config
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit system_name;
      inherit config_path;
    };
    users = {
      "gus" = import ../home/hyprland/home.nix;
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking = {
    firewall.allowedTCPPorts = [57621 3000]; # --> https://nixos.wiki/wiki/Spotify
    firewall.allowedUDPPorts = [5353]; # --> https://nixos.wiki/wiki/Spotify
    hostName = system_name;
  };

  # Enable docker
  virtualisation.docker = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
