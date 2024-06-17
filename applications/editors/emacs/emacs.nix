{pkgs, ...}:
{
  services.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };
  home.packages = [
    (pkgs.emacsWithPackagesFromUsePackage {

      config = ./emacs.el;
      defaultInitFile = true;

      package = pkgs.emacs-pgtk;

      alwaysEnsure = true;

      extraEmacsPackages = epkgs: [
        epkgs.magit
	epkgs.evil
        epkgs.goto-chg
        epkgs.undo-tree
      ];
    })
  ];
}
