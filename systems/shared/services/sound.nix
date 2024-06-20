{...}:
{
  hardware = {
    pulseaudio.enable = false;
  };
  sound.enable = true;
  pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
}
