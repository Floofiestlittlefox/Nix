{pkgs, inputs, ...}:
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];
  home.packages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
      bun
      fuzzel
      matugen
      hyprlock
      hyprpaper
      hyprpicker
      fd
      dart-sass
      brightnessctl
      fswatch
    ];


  programs.ags = {
    enable = true;

    configDir = ../ags;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
      bun
      fuzzel
      matugen
      hyprlock
      hyprpaper
      hyprpicker
      fd
      dart-sass
      brightnessctl
    ];
  };
}
