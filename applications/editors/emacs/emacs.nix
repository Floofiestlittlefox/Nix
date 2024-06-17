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
	epkgs.lsp-bridge
	epkgs.yasnippet
	epkgs.acm-terminal
        epkgs.ace-popup-menu
        epkgs.pulsar
        epkgs.workgroups2
        epkgs.ivy
        epkgs.swiper
        epkgs.counsel
        epkgs.sublimity
        epkgs.ef-themes

	epkgs.auctex
	epkgs.auctex-latexmk
	epkgs.cdlatex
	epkgs.lsp-latex
      ];
    })
  ];
}
