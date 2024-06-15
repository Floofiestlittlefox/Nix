{pkgs, inputs, ...}:
{

  nixpkgs.overlays = [ (import inputs.emacs-overlay) ];

  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs-unstable;

  home.packages = [
    (pkgs.emacsWithPackagesFromUsePackage {

      config = ./emacs/emacs.el;

      defaultInitFile = true;

      alwaysEnsure = true;

      alwaysTangle = true;

      extraEmacsPackages = with pkgs.epkgs; [ 
        cask
      ];
    })
  ];
}
