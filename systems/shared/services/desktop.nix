{ pkgs, inputs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
		appimage-run
                libinput-gestures
                wmctrl
  ];
  services = {
    flatpak.enable = true;
    libinput.enable = true;
    desktopManager= {
      plasma6.enable = true;
    };
    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
      defaultSession = "hyprland";
    };
    
    xserver = {
      enable = true;
      displayManager = {
       gdm.enable = false;
      };
      desktopManager = {
        gnome.enable = false;
        runXdgAutostartIfNone = true;
      };
    };
  };
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    ssh.askPassword = lib.mkForce "true";
  };
  virtualisation = {
    waydroid.enable = false;
  };
}
    
