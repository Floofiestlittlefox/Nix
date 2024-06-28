{pkgs, ...}:
{
  home.packages = with pkgs.kdePackages; [
    breeze
    qtwayland
    pkgs.libsForQt5.qt5.qtwayland
  ];
  qt = {
    enable = true;
    platformTheme.name = "kde";
  };
}
