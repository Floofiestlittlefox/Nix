{ ... }:
{
  services = {
    power-profiles-daemon.enable = false;
    virtualisation = {
      docker = {
        enable = true;
        liverestore = false;
      };
    };
  };
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
