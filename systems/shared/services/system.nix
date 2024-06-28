{pkgs, ... }:
{
  programs = {
    dconf.enable = true;
  };
  services = {
    sysprof.enable = true;
    udev = {
      enable = true;
      packages = [ pkgs.gnome.gnome-settings-daemon ];
      extraRules = ''
        ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
        '';
    };
  };
  security.polkit.enable = true;
}
