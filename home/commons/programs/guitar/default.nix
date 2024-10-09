{ pkgs, ... }:
{
  home.packages = [
    # Install Guitarix
    pkgs.guitarix
  ];

  # When running Guitarix, activate PipeWire jack support and start Jack server
  home.file.".config/guitarix/gx_head_fx.conf".text = ''
    [jack]
    enable=1
    clientname=guitarix
    portname=guitarix
    samplerate=48000
    period=128
    nperiods=3
    latency=0
    priority=75
    servername=pipewire
  '';

}
