{ ... }:
{
  services = {
    power-profiles-daemon.enable = false;
      };
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
  virtualisation = {
      docker = {
        enable = true;
        liveRestore = false;
      };
    };

}
