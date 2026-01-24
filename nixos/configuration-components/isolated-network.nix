{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.isolatedNetwork;
in {
  options.services.isolatedNetwork = {
    enable = mkEnableOption "isolated WiFi network";

    interface = mkOption {
      type = types.str;
      default = "wlan0";
      description = "WiFi interface to use for the access point";
    };

    ssid = mkOption {
      type = types.str;
      default = "IsolatedNetwork";
      description = "SSID of the isolated network";
    };

    password = mkOption {
      type = types.str;
      description = "WiFi password (minimum 8 characters)";
    };

    ipAddress = mkOption {
      type = types.str;
      default = "192.168.4.1";
      description = "Static IP address for the access point";
    };

    dhcpRange = mkOption {
      type = types.str;
      default = "192.168.4.2,192.168.4.20";
      description = "DHCP range for connected devices";
    };

    channel = mkOption {
      type = types.int;
      default = 7;
      description = "WiFi channel to use";
    };
  };

  config = mkIf cfg.enable {
    # Disable NetworkManager on the AP interface
    networking.networkmanager.unmanaged = [cfg.interface];

    # Password file for hostapd
    environment.etc."hostapd-isolated.wpa_psk" = {
      text = cfg.password;
      mode = "0600";
    };

    # Configure the access point
    services.hostapd = {
      enable = true;
      radios.${cfg.interface} = {
        band = "2g";
        channel = cfg.channel;
        networks.${cfg.interface} = {
          ssid = cfg.ssid;
          authentication = {
            mode = "wpa2-sha256";
            wpaPasswordFile = "/etc/hostapd-isolated.wpa_psk";
          };
        };
      };
    };

    # Configure DHCP server
    services.dnsmasq = {
      enable = true;
      settings = {
        interface = cfg.interface;
        dhcp-range = "${cfg.dhcpRange},24h";
        bind-interfaces = true;
        no-resolv = true;
        no-poll = true;
      };
    };

    # Set static IP for the interface
    networking.interfaces.${cfg.interface}.ipv4.addresses = [
      {
        address = cfg.ipAddress;
        prefixLength = 24;
      }
    ];

    # Ensure IP forwarding is disabled (keeps network isolated)
    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 0;
      "net.ipv6.conf.all.forwarding" = 0;
    };

    # Allow DHCP and DNS traffic on the firewall
    networking.firewall = {
      allowedUDPPorts = [53 67];
      interfaces.${cfg.interface} = {
        allowedTCPPorts = [53];
        allowedUDPPorts = [53 67 68];
      };
    };
  };
}
