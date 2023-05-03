;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Identity
(setq user-full-name "Kevin Kaiser"
      user-mail-address "k8x1d@proton.me")

;; Fonts
(setq doom-font (font-spec :family "JuliaMono" :size 18)
      doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 22))

;; Theme
(setq doom-theme 'doom-gruvbox)
(setq doom-gruvbox-dark-variant "hard")

;; Ui
(setq display-line-numbers-type t)
(doom/set-frame-opacity 85)


;;; Org (General Configurations)
(setq org-directory "~/Dropbox/org/")
(setq org-agenda-files (file-expand-wildcards (concat org-directory "/gtd/*.org")))

;; Roam
(setq org-roam-directory (concat org-directory "/roam"))

;;; Writing support
(setq reftex-default-bibliography "/home/k8x1d/Zotero/k8x1d.bib")
(setq +latex-viewers '(pdf-tools))

(use-package pdf-tools
  :hook (pdf-view-mode . pdf-view-midnight-minor-mode))

(setq citar-bibliography '("/home/k8x1d/Zotero/k8x1d.bib")
      citar-library-paths '("/home/k8x1d/Zotero/storage/")
      citar-notes-paths '("/home/k8x1d/Zotero/notes/"))

;; Set splash image
(setq-default
 +doom-dashboard-banner-dir (expand-file-name "splash/" doom-private-dir)
 +doom-dashboard-banner-file "doom-emacs-color.png"
 )

;;; Julia (better) support
(use-package! julia-vterm
  :hook
  (julia-mode . julia-vterm-mode)
  :config
  ;;(setq julia-vterm-repl-program "/usr/bin/julia -t 12")
  (map! :localleader
        :map julia-mode-map
        "'" #'julia-vterm-switch-to-repl-buffer
        "RET" #'julia-vterm-send-region-or-current-line
        "b" #'julia-vterm-send-buffer
        "f" #'julia-vterm-send-include-buffer-file
        "d" #'julia-vterm-send-cd-to-buffer-directory))

(use-package! ob-julia-vterm
  :config
  (add-to-list 'org-babel-load-languages '(julia-vterm . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
  (defalias 'org-babel-variable-assignments:julia 'org-babel-variable-assignments:julia-vterm)
  )

;;(use-package! eglot-jl
;;  :config
;;  ;;(setq! eglot-jl-julia-command (shell-command-to-string "which julia"))
;;  (setq! eglot-jl-language-server-project "~/.julia/environments/v1.8"))
