;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

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

(setq user-full-name "Kevin Kaiser"
      user-mail-address "k8x1d@protonmail.ch")

  (unless (featurep 'pgtk)
    (set-frame-parameter (selected-frame) 'alpha '(85 . 85))
    (add-to-list 'default-frame-alist '(alpha . (85 . 85)))
    (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
    (add-to-list 'default-frame-alist '(fullscreen . maximized))

    ;; ;; Set transparency of emacs
    (defun kk/transparency (value)
      "Sets the transparency of the frame window. 0=transparent/100=opaque"
      (interactive "nTransparency Value 0 - 100 opaque:")
      (set-frame-parameter (selected-frame) 'alpha value)))

  ;; For emacs pgtk >= 29
  (when (featurep 'pgtk)
    (if (version< emacs-version "29")
        ;; initial transparency
        (set-frame-parameter nil 'alpha-background 100)
      (add-to-list 'default-frame-alist '(alpha-background . 100))

      ;; function to change transparency
      (defun kk/transparency (value)
        "Sets the transparency of the frame window. 0=transparent/100=opaque"
        (interactive "nTransparency Value 0 - 100 opaque:")
        (set-frame-parameter (selected-frame) 'alpha-background value))))

;;(use-package! emacs
;;  :init
;;  ;; Add all your customizations prior to loading the themes
;;  (setq modus-themes-italic-constructs t
;;        modus-themes-bold-constructs nil
;;        modus-themes-region '(bg-only no-extend))
;;  ;;(setq modus-themes-mixed-fonts t)
;;  ;; Main typeface
;;  (set-face-attribute 'default nil :family "JuliaMono" :height 120)
;;  ;; Proportionately spaced typeface
;;  (set-face-attribute 'variable-pitch nil :family "DejaVu Sans" :height 1.5)
;;  ;; Monospaced typeface
;;  (set-face-attribute 'fixed-pitch nil :family "JuliaMono" :height 1.0)
;;  :config
;;  (setq doom-theme 'modus-vivendi)
;;  :hook
;;  ;;(text-mode . variable-pitch-mode)
;;  (text-mode . mixed-pitch-mode)
;;  :bind ("<f5>" . modus-themes-toggle))

(use-package! emacs
  :init
  ;; Main typeface
  ;;(set-face-attribute 'default nil :family "JuliaMono" :height 120)
  (set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 120)
  ;; Proportionately spaced typeface
  (set-face-attribute 'variable-pitch nil :family "DejaVu Sans" :height 1.5)
  ;; Monospaced typeface
  ;;(set-face-attribute 'fixed-pitch nil :family "JuliaMono" :height 1.0)
  (set-face-attribute 'fixed-pitch nil :family "DejaVu Sans Mono" :height 1.0)
  :config
  (setq doom-theme 'doom-gruvbox)
  :hook
  (text-mode . mixed-pitch-mode))

(setq display-line-numbers-type t)

(setq fancy-splash-image (concat doom-private-dir "splash/" "doom-emacs-color.png"))

(setq org-directory "~/org/")

(use-package! org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-remove-leading-stars t)
  (setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))

;;(setq lsp-julia-package-dir nil)
;;(after! lsp-julia
;;  (setq lsp-julia-default-environment "~/.julia/environments/v1.7"))

(setq eglot-jl-language-server-project "~/.julia/environments/v1.7")
(after! eglot-jl
  (setq eglot-jl-language-server-project eglot-jl-base))

(use-package! julia-vterm
  :hook (julia-mode . julia-vterm-mode)
  ;;:bind-keymap
  ;;("C-<return>" . julia-vterm-send-region-or-current-line)
  :config
  (setq julia-vterm-repl-program "/nix/var/nix/profiles/per-user/k8x1d/profile/bin/julia -t 4")
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
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))

(use-package! R-vterm
  :hook (ess-r-mode . R-vterm-mode)
  :config
  (map! :localleader
        :map ess-r-mode-map
        "'" #'R-vterm-switch-to-repl-buffer
        "RET" #'R-vterm-send-region-or-current-line
        "b" #'R-vterm-send-buffer
        "f" #'R-vterm-send-include-buffer-file
        "d" #'R-vterm-send-cd-to-buffer-directory))

(setq +latex-viewers '(pdf-tools))

(setq! reftex-default-bibliography "~/Zotero/k8x1d.bib")
(setq! bibtex-completion-bibliography '("~/Zotero/k8x1d.bib"))

(setq! bibtex-completion-library-path '("~/Zotero/storage"))
(map! :leader :desc "Open a PDF" "oz" #'ivy-bibtex)

(use-package! pdf-tools
  :hook (pdf-view-mode . pdf-view-midnight-minor-mode))

;;(use-package! lsp-ltex
;;  :hook (LaTeX-mode . (lambda ()
;;                        (require 'lsp-ltex)
;;                        (lsp-deferred)))
;;  :init
;;  (setq lsp-ltex-version "15.2.0"))
;;
;;(defun kk/start-ltex ()
;;  (interactive)
;;  (require 'lsp-ltex)
;;  (call-interactively #'lsp))

(setq eglot-languagetool-server-path "~/Documents/Logiciels/editors_set-up/ltex-ls-15.2.0")

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (require 'eglot-ltex)
            (call-interactively #'eglot)))

(defun kk/start-ltex ()
  (interactive)
  (require 'eglot-ltex)
  (call-interactively #'eglot))

(setq flycheck-checker-error-threshold 1000)
;;(ispell-change-dictionary "en_US" t)
(setq lsp-ui-sideline-show-code-actions t)

;;(setq inhibit-x-resources t)
;;(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
;;(server-start)
