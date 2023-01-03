;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;;(setq user-full-name "John Doe"
;;      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;;(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(add-to-list 'default-frame-alist '(background-color . "#282828"))

(if (string-equal (getenv "THEME_VARIANT") "Light")
    (setq fancy-splash-image (concat doom-private-dir "splash/" "doom-emacs-color2.png"))
  (setq fancy-splash-image (concat doom-private-dir "splash/" "doom-emacs-color.png")))

(if (string-equal (getenv "THEME_VARIANT") "Light")
    (setq doom-theme 'doom-gruvbox-light)
  (setq doom-theme 'doom-gruvbox))

(setq display-line-numbers-type t)

(setq org-directory "~/org")

(setq user-full-name "Kevin Kaiser"
      user-mail-address "k8x1d@proton.me")

;;(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 16)
;;      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 16))


(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 16 :weight 'normal)
      doom-big-font (font-spec :family "DejaVu Sans Mono" :size 20 :weight 'normal)
      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 16))

(setq auth-sources '("~/.authinfo"))

;;(add-hook 'after-init-hook 'global-hl-line-mode)

;;(use-package! mixed-pitch
;;  :hook
;;  ;; If you want it in all text modes:
;;  (text-mode . mixed-pitch-mode))

(setq reftex-default-bibliography "/home/k8x1d/Zotero/k8x1d.bib")
(setq +latex-viewers '(pdf-tools))

(use-package! pdf-tools
  :hook (pdf-view-mode . pdf-view-midnight-minor-mode))

(setq! citar-bibliography '("/home/k8x1d/Zotero/k8x1d.bib"))
(setq! citar-library-paths '("/home/k8x1d/Zotero/storage/")
       citar-notes-paths '("/home/k8x1d/Zotero/notes/"))

;;;;; For emacs < 29
;;;(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
;;;(add-to-list 'default-frame-alist '(alpha . (90 . 90)))
;;;(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
;;;(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;;; ;; Set transparency of emacs
;;(defun kk/transparency (value)
;;  "Sets the transparency of the frame window. 0=transparent/100=opaque"
;;  (interactive "nTransparency Value 0 - 100 opaque:")
;;  (set-frame-parameter (selected-frame) 'alpha value))

;;;; For emacs >= 29
;;(set-frame-parameter nil 'alpha-background 80)
;;(add-to-list 'default-frame-alist '(alpha-background . 80))
;;
;;;; function to change transparency
;;(defun kk/transparency (value)
;;  "Sets the transparency of the frame window. 0=transparent/100=opaque"
;;  (interactive "nTransparency Value 0 - 100 opaque:")
;;  (set-frame-parameter (selected-frame) 'alpha-background value))

;; (use-package! org-pomodoro
;;   :config
;;   (setq org-pomodoro-length 50)
;;   (setq org-pomodoro-short-break-length 10)
;;   (setq org-pomodoro-long-break-length 30))
(setq alert-user-configuration (quote ((((:category . "org-pomodoro")) libnotify nil))))
(setq org-pomodoro-length 50)
(setq org-pomodoro-short-break-length 10)
(setq org-pomodoro-long-break-length 30)

(remove-hook 'org-mode-hook #'+org-enable-auto-reformat-tables-h)

(add-hook! 'text-mode-hook #'mixed-pitch-mode)
(add-hook! 'text-mode-hook #'solaire-mode)
(setq mixed-pitch-variable-pitch-cursor nil)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

;;(after! lsp-julia
;;  (setq lsp-julia-default-environment "~/.julia/environments/v1.8"))

(after! julia-repl
  (julia-repl-set-terminal-backend 'vterm)
  (setq vterm-kill-buffer-on-exit nil))

(setq eglot-jl-language-server-project "~/.julia/environments/v1.8")


;;(use-package! julia-vterm
;;  :hook
;;  (julia-mode . julia-vterm-mode)
;;  :config
;;  ;;(setq julia-vterm-repl-program "/usr/bin/julia -t 12")
;;  (map! :localleader
;;        :map julia-mode-map
;;        "'" #'julia-vterm-switch-to-repl-buffer
;;        "RET" #'julia-vterm-send-region-or-current-line
;;        "b" #'julia-vterm-send-buffer
;;        "f" #'julia-vterm-send-include-buffer-file
;;        "d" #'julia-vterm-send-cd-to-buffer-directory))
;;
;;(use-package! ob-julia-vterm
;;  :config
;;  (add-to-list 'org-babel-load-languages '(julia-vterm . t))
;;  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
;;  (defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
;;  (defalias 'org-babel-variable-assignments:julia 'org-babel-variable-assignments:julia-vterm)
;;  )

;;(use-package! lsp-ltex
;;  :hook (LaTeX-mode . (lambda ()
;;                        (require 'lsp-ltex)
;;                        (lsp-deferred)))
;;  :init
;;  (setq lsp-ltex-version "15.2.0")
;;  :config
;;  (defun kk/start-ltex ()
;;    (interactive)
;;    (require 'lsp-ltex)
;;    (call-interactively #'lsp))
;;  )


(use-package! eglot-ltex
  :hook (LaTeX-mode . (lambda ()
                        (require 'lsp-ltex)
                        (lsp-deferred)))
  :init
  (setq eglot-languagetool-server-path "~/Documents/Developpement/Logiciels/Editeurs/2022/A/ltex-ls-15.2.0/")
  :config
  (defun kk/start-ltex ()
    (interactive)
    (require 'eglot-ltex)
    (call-interactively #'eglot))
  )
