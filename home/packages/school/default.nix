{pkgs, inputs,...}:
{
  home.packages = with pkgs; [
		calibre
		libreoffice
		obsidian
		p3x-onenote
                inputs.typst.packages.${pkgs.system}.default
		typst-lsp
		zotero
		qalculate-qt
		rnote
                logseq
                texliveFull
  ];
}
