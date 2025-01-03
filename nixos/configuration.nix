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
} :
let
  hardware-configuration =  ./${system_name}-hardware-configuration.nix;
  lvm-disk = if system_name == "spaceship" then [ ./configuration-components/disks.nix ] else [./configuration-components/bluetooth.nix];
in
{
  imports = [
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
  ] ++ lvm-disk;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gus = {
    isNormalUser = true;
    description = "gus";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "gus";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  # Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    kitty
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    nh # --> CLI for NixOs
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    glxinfo
    chromium
  ];

  fonts.packages = [] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

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

  # Enable locate file finder
  services.locate.enable = true;

  # Enable Hyprland
  programs.hyprland.enable = true;
  #programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland; # --> Use flake

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
  networking.firewall.allowedTCPPorts = [ 57621 ]; # --> https://nixos.wiki/wiki/Spotify
  networking.firewall.allowedUDPPorts = [ 5353 ]; # --> https://nixos.wiki/wiki/Spotify

  networking.hostName = system_name;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
