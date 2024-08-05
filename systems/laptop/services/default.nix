{...}:
{
  services = {
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };
    libinput.enable = true;
  };
  virtualisation = {
    docker.enable = false;
  };
  hardware = {
    sensor.iio.enable = true;
  };
  powerManagement.powertop.enable = true;
}
