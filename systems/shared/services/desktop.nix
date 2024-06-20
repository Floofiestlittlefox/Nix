{ pkgs, inputs, ... }:
{
  home.packages = [
		appimage-run
  ];
  services = {
    flatpak.enable = true;
    libinput.enable = true;
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        defaultSession = "hyprland";
      };
      desktopManager = {
        gnome.enable = true;
        runXdgAutostartIfNone = true;
      };
    };
  };
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
  };
}
    
