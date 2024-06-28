{inputs, pkgs, ...}:
{
  imports = [
    ./qt.nix
    ./gtk.nix
  ];
  home.pointerCursor = {
    gtk.enable = true;
    name = "Vulpix";
    package = inputs.vulpix.packages.${pkgs.system}.vulpix;
    size = 24;
  };
      
}
