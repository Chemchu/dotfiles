{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.framework13Configuration = {
    config,
    pkgs,
    lib,
    ...
  }: let
    nativeLibs = with pkgs; [
      vulkan-tools
      vulkan-headers
      vulkan-loader
      openssl
      gtk3
      pkg-config
      alsa-lib
      libx11
      libxrandr
      libxcursor
      libXi
      libxkbcommon
      libglvnd
      glibc
      libsoup_3
      webkitgtk_4_1
      udev
      wayland
      pipewire.jack
    ];
  in {
    imports = [
      inputs.home-manager.nixosModules.default
      self.nixosModules.framework13Hardware
    ];

    users = {
      defaultUserShell = pkgs.zsh;
      users.gus = {
        isNormalUser = true;
        description = "gus";
        extraGroups = ["audio" "networkmanager" "wheel" "input" "wireshark"];
      };
    };

    time.timeZone = "Eire";
    i18n.defaultLocale = "es_ES.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "es_ES.UTF-8";
      LC_IDENTIFICATION = "es_ES.UTF-8";
      LC_MEASUREMENT = "es_ES.UTF-8";
      LC_MONETARY = "es_ES.UTF-8";
      LC_NAME = "es_ES.UTF-8";
      LC_NUMERIC = "es_ES.UTF-8";
      LC_PAPER = "es_ES.UTF-8";
      LC_TELEPHONE = "es_ES.UTF-8";
      LC_TIME = "es_ES.UTF-8";
    };

    nixpkgs.config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];

    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
      extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';
    };

    networking = {
      hostName = "framework13";
      networkmanager.enable = true;
      firewall = {
        allowedTCPPorts = [57621 3000];
        allowedUDPPorts = [5353];
      };
    };

    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          libvdpau-va-gl
        ];
      };
    };

    environment = {
      variables = {
        LD_LIBRARY_PATH = lib.mkForce (lib.makeLibraryPath nativeLibs);
        PKG_CONFIG_PATH = "${pkgs.alsa-lib.dev}/lib/pkgconfig:${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.systemd.dev}/lib/pkgconfig";
        XDG_DATA_DIRS = lib.mkForce "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS";
      };
      sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
        GTK_IM_MODULE = "ibus";
        EDITOR = "vim";
      };
      systemPackages = with pkgs; [
        git
        vim
        wget
        kitty
        libsForQt5.qt5.qtquickcontrols2
        libsForQt5.qt5.qtgraphicaleffects
        libsForQt5.qt5.qtwayland
        qt6.qtwayland
        mesa-demos
      ];
    };

    programs = {
      nix-ld = {
        enable = true;
        libraries = with pkgs;
          [
            curl
            wget
            dbus
            openssl_3
            glib
            librsvg
            cmake
            cairo
            ninja
            pugixml
            libgcc
            glibc
            libsoup_3
            webkitgtk_4_1
            pipewire.jack
          ]
          ++ nativeLibs;
      };
      zsh.enable = true;
      firefox = {
        enable = true;
        package = pkgs.firefox-bin;
      };
      java.enable = false;
      hyprland.enable = false;
      wireshark = {
        enable = true;
        usbmon.enable = true;
      };
      nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        flake = "/home/gus/dotfiles";
      };
    };

    fonts.packages = with pkgs.nerd-fonts; [iosevka iosevka-term];

    security = {
      polkit.enable = true;
      rtkit.enable = true;
    };

    services = {
      upower.enable = true;
      blueman.enable = true;
      deluge = {
        enable = true;
        web.enable = true;
      };
      getty.autologinUser = "gus";
      locate.enable = true;
      pipewire = {
        enable = true;
        pulse.enable = true;
        jack.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
      };
      xserver = {
        enable = true;
        displayManager.startx.enable = true;
        videoDrivers = ["amdgpu"];
        xkb.layout = "es";
      };
    };

    console.keyMap = "es";

    powerManagement = {
      enable = true;
      cpuFreqGovernor = lib.mkDefault "powersave";
    };

    virtualisation.docker.enable = true;

    home-manager.users.gus = self.homeModules.gus;

    system.stateVersion = "23.11";
  };
}
