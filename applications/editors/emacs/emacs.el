(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)

(setq 
  display-line-numbers 'relative)

(require
 'evil
 'undo-tree)

(evil-mode 1)
(global-undo-tree-mode 1)
