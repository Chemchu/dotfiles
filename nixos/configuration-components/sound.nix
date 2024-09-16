{
  # Enable sound with pipewire
  #sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    # jack.enable = true; # Check if you need this

    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
}
