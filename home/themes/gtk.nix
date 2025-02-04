{pkgs, inputs, ...}:
{
  home.packages = with pkgs; [
    adwaita-icon-theme
  ];
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Vulpix";
      package = inputs.vulpix.packages.${pkgs.system}.vulpix;
      size = 24;
    };
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Orange-Dark";
    };
    iconTheme = {
      name = "ePapirus-dark";
      package = pkgs.epapirus-icon-theme;
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };
}
    
    
  
