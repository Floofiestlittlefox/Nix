{ pkgs, inputs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
		appimage-run
                wmctrl
  ];
  services = {
    flatpak.enable = true;
    libinput.enable = true;
    displayManager = {
      defaultSession = "hyprland";
    };
    dbus = {
      enable = true;
    };
    xserver = {
      enable = true;
      displayManager = {
       gdm.enable = true;
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
    
