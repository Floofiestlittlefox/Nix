(setq lexical-binding t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)

(setq display-line-numbers 'relative)

(require 'undo-tree)
;;(global-undo-tree-mode)

(require 'evil)
;;(setq evil-undo-system 'undo-tree)

(evil-mode 1)

(require 'sublimity)
(require 'sublimity-scroll)
(require 'sublimity-attractive)
(sublimity-mode 1)

;; Latex
(require 'auctex)
(require 'auctex-latexmk)
(require 'cdlatex)

(TeX-fold-mode 1)


(require 'ace-popup-menu)
(ace-popup-menu-mode 1)

(require 'workgroups2)
(workgroups-mode 1)

(require 'ivy)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;;(global-set-key (kbd "C-c C-r") 'ivy-resume)
;;(global-set-key (kbd "<f6>") 'ivy-resume)

(require 'counsel)
;;(counsel-mode 1)

(require 'swiper)
;;(define-key evil-normal-state-map (kbd "/") 'swiper)

(defun mk-flyspell-correct-previous (&optional words)
  "Correct word before point, reach distant words.

WORDS words at maximum are traversed backward until a misspelled
word is found.  If the argument WORDS is not specified, traverse
12 words by default.

Return T if a misspelled word is found and NIL otherwise.  Never
move the point."
  (interactive "P")
  (let* ((delta (- (point-max) (point)))
         (counter (string-to-number (or words "12")))
         (result
          (catch 'result
            (while (>= counter 0)
              (when (cl-some #'flyspell-overlay-p
                             (overlays-at (point)))
                (flyspell-correct-word-before-point)
                (throw 'result t))
              (backward-word 1)
              (setq counter (1- counter))
              nil))))
    (goto-char (- (point-max) delta))
    result))
