{pkgs, ...}:
{
  home.packages = with pkgs.kdePackages; [
    breeze
    systemsettings
    qtwayland
  ];
  home.packages = with pkgs.libsForQt5; [
    qt5.qtwayland
  ];
  qt = {
    enable = true;
    platformTheme.name = "kde";
  };
}
