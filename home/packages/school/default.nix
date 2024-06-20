{pkgs, ...}:
{
  home.packages = with pkgs; [
		calibre
		libreoffice
		obsidian
		p3x-onenote
		typst
		typst-lsp
		zotero
		qalculate-qt
		rnote
  ];
}
