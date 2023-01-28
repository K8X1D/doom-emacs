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

;; Adjust splash image
  (setq-default
   +doom-dashboard-banner-dir (expand-file-name "splash/" doom-private-dir)
   +doom-dashboard-banner-file "doom-emacs-color.png"
   )

;; Esthetics
(setq! doom-theme 'doom-gruvbox)
(custom-set-faces
  `(cursor ((t (:background "#ebddb2")))) ;; from white
;; Add 1 tone to hl-line face
  `(hl-line ((t (:background "#504945")))) ;; from #3c3836
  `(solaire-hl-line-face ((t (:background "#3c3836"))))) ;; from #282828

;;(setq! doom-gruvbox-dark-variant "hard")
;;(setq! doom-gruvbox-brighter-comments t)


(setq! display-line-numbers-type t)
;;(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 16 :weight 'normal)
;;      doom-big-font (font-spec :family "DejaVu Sans Mono" :size 20 :weight 'normal)
;;      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 14)
;;      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 16))

;; Under evaluation...
(setq! doom-font (font-spec :family "Fira Code" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 16))


(if (>= emacs-major-version 29)
    (add-hook 'after-init-hook 'pixel-scroll-precision-mode))

;;;; Frames opacity (based on version and pgtk build)
;; seems to cause problem on pgtk 28
;;(if (and (eq window-system 'pgtk) (>= emacs-major-version 29))
;;    (progn
;;      (set-frame-parameter nil 'alpha-background 80)
;;      (add-to-list 'default-frame-alist '(alpha-background . 80)))
;;  (progn
;;    (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
;;    (add-to-list 'default-frame-alist '(alpha . (90 . 90)))))


(setq! tab-bar-show nil) ;; Ensure that tab don't show

;; Vertico configuration
  (setq! vertico-posframe-parameters
      '((left-fringe . 8)
        (right-fringe . 8)))

;;Correct candidate hiding when names are long
;; - see https://github.com/tumashu/vertico-posframe/issues/14
(setq! vertico-posframe-truncate-lines nil)


;;;
;;; Org
;;;

;;; Org (General Configurations)
(setq! org-directory "~/org")
(remove-hook 'org-mode-hook #'+org-enable-auto-reformat-tables-h) ;; stop autoreformating for tables

;;; Esthetics

;; Priorities symbols
(use-package! org-fancy-priorities
  :config
  (setq! org-fancy-priorities-list '("[HIGH]" "[MID]" "[LOW]")))

;; Bullets symbols
(use-package! org-superstar
  :config
  (setq! org-superstar-headline-bullets-list '("◉" "○" "◈" "◇" "✳")))


;; Emphasis markers configurations
;;(setq! org-hide-emphasis-markers t)
(setq! org-hide-emphasis-markers t
       org-appear-autoemphasis t
       org-appear-autolinks t)

;; Show emphasis marker only in evil-insert state
;; from https://github.com/awth13/org-appear
(add-hook! 'org-mode-hook 'org-appear-mode)
(setq! org-appear-trigger 'manual)
(add-hook 'org-mode-hook (lambda ()
                           (add-hook 'evil-insert-state-entry-hook
                                     #'org-appear-manual-start
                                     nil
                                     t)
                           (add-hook 'evil-insert-state-exit-hook
                                     #'org-appear-manual-stop
                                     nil
                                     t)))

;; Personal information
(setq! user-full-name "Kevin Kaiser"
      user-mail-address "k8x1d@proton.me")


;; Authorization file
(setq! auth-sources '("~/.authinfo.gpg"))

;;; Writing support
(setq! reftex-default-bibliography "/home/k8x1d/Zotero/k8x1d.bib")
(setq! +latex-viewers '(pdf-tools))

(use-package! pdf-tools
  :hook (pdf-view-mode . pdf-view-midnight-minor-mode))

(setq! citar-bibliography '("/home/k8x1d/Zotero/k8x1d.bib")
       citar-library-paths '("/home/k8x1d/Zotero/storage/")
       citar-notes-paths '("/home/k8x1d/Zotero/notes/"))

;; Pomodoro configuration
(setq! alert-user-configuration (quote ((((:category . "org-pomodoro")) libnotify nil))))
(setq! org-pomodoro-length 50)
(setq! org-pomodoro-short-break-length 10)
(setq! org-pomodoro-long-break-length 30)



(add-hook! 'text-mode-hook #'mixed-pitch-mode)
(add-hook! 'text-mode-hook #'solaire-mode)
(setq! mixed-pitch-variable-pitch-cursor nil)

(setq! browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")


(if (eq window-system 'pgtk)
    (setq! treemacs-read-string-input 'from-minibuffer))


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

(use-package! eglot-jl
  :config
  (setq! eglot-jl-language-server-project "~/.julia/environments/v1.8"))


;;; Languagetool support
;; To set language, add the following to file been edited
;; -  BibTEX: Same as LATEX
;; -  LATEX: % LTeX: SETTINGS
;; -  Markdown: One of the following:
;; -      <!-- LTeX: SETTINGS -->
;; -      [comment]: <> "LTeX: SETTINGS"
;; -  Org: # LTeX: SETTINGS
;; -  reStructuredText: .. LTeX: SETTINGS
;; -  R Sweave: Same as LATEX
;; -  XHTML: No support for magic comments
;; -  Programming languages: LTeX: SETTINGS inside a line comment or a single-line block comment
;; see https://valentjn.github.io/ltex/advanced-usage.html

(use-package! eglot-ltex
  :config
  (defun k8x1d/start-ltex ()
    (interactive)
    (require 'eglot-ltex)
    (call-interactively #'eglot))
  (setq! eglot-languagetool-server-path "~/Documents/Developpement/Logiciels/Editeurs/2022/A/ltex-ls-15.2.0/")
  )



;;; Helper funcitons
;; test if pgtk
  (defun k8x1d/test-pgtk ()
    (interactive)
    (if (eq window-system 'pgtk)
        (print "yes")
      (print "no")))


;;; Babel
;;

;;;; Extra supported languages
;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((dot . t))) ; this line activates dot


;;; Graphviz support
;; syntax
(use-package graphviz-dot-mode
  :config
  (setq graphviz-dot-indent-width 4))

;; completion
(use-package company-graphviz-dot)


;;;
;;; Completion
;;;
;;;

(use-package! company
  :config
  (setq! company-global-modes '(not org-mode)) ;; exclude following modes
 ;; (setq! tab-always-indent 'complete)
 ;; (setq! company-idle-delay nil)
  )



;;
;; Syntax checker
;;

;; flyceck with ess have high cpu demand. Turn off by efault.
(use-package! flycheck
  :config
  (setq flycheck-global-modes '(not ess-r-mode ess-mode))
  ;;(setq! flycheck-idle-change-delay 5.0)
  )



;;
;; Mail
;;

;;;; Enabling automatic email fetching
;;;; ;;setq mu4e-get-mail-command "mbsync gmail proton"
;;;; ;;;; get emails and index every 5 minutes
;;;; ;;mu4e-update-interval 300
;;;; ;;;; send emails with format=flowed
;;;; ;;mu4e-compose-format-flowed t
;;;; ;;;; no need to run cleanup after indexing for gmail
;;;; ;;mu4e-index-cleanup nil
;;;; ;;mu4e-index-lazy-check t
;;;; ;;;; more sensible date format
;;;; ;;mu4e-headers-date-format "%d.%m.%y")
;;;; ;;;; Get mail
;;;; ;;setq mu4e-get-mail-command "mbsync proton"
;;;; ;;mu4e-change-filenames-when-moving t   ; needed for mbsync
;;;; ;;mu4e-update-interval 120)             ; update every 2 minutes
;;;; ;;;; Send mail
;;;; ;;setq message-send-mail-function 'smtpmail-send-it
;;;; ;;smtpmail-auth-credentials "~/.authinfo.gpg" ;; Here I assume you encrypted the credentials
;;;; ;;smtpmail-smtp-server "127.0.0.1"
;;;; ;;smtpmail-smtp-service 1025)
;;;; ;;


;; ;;;; Each path is relative to the path of the maildir you passed to mu
(set-email-account! "proton"
                    '(
                      (mu4e-sent-folder       . "/proton/sent")
                      (mu4e-drafts-folder     . "/proton/drafts")
                      (mu4e-trash-folder      . "/proton/trash")
                      (mu4e-refile-folder     . "/proton/All_Mail")
                      (smtpmail-smtp-user     . "k8x1d@proton.me")
                      (smtpmail-smtp-server . "127.0.0.1")
                      (message-send-mail-function . smtpmail-send-it)
                      (starttls-use-gnutls . t)
                      (smtpmail-stream-type . starttls)
                      (smtpmail-smtp-service . 1025)
                      (mu4e-compose-signature . "---\nYours truly\nThe Baz"))
                    t)

(set-email-account! "gmail"
                    '(
                      (mu4e-sent-folder       . "/gmail/Sent_Mail")
                      (mu4e-drafts-folder     . "/gmail/Drafts")
                      (mu4e-trash-folder      . "/gmail/Trash")
                      (mu4e-refile-folder     . "/gmail/All_Mail")
                      (smtpmail-smtp-user     . "k8x1d90@gmail.com")
                      (smtpmail-default-smtp-server . "smtp.gmail.com")
                      (smtpmail-smtp-server . "smtp.gmail.com")
                      (smtpmail-smtp-service . 587)
                      (mu4e-compose-signature . "---\nYours truly\nThe Baz"))
                    t)


;; Need to fix mbsync...
;;;;; From https://github.com/harishkrupo/oauth2ms/blob/main/steps.org
;; ;;; Call the oauth2ms program to fetch the authentication token
;;   (defun fetch-access-token ()
;;     (with-temp-buffer
;;	(call-process "oauth2ms" nil t nil "--encode-xoauth2")
;;	(buffer-string)))
;;
;;   ;;; Add new authentication method for xoauth2
;;   (cl-defmethod smtpmail-try-auth-method
;;     (process (_mech (eql xoauth2)) user password)
;;     (let* ((access-token (fetch-access-token)))
;;	(smtpmail-command-or-throw
;;	 process
;;	 (concat "AUTH XOAUTH2 " access-token)
;;	 235)))
;;
;;   ;;; Register the method
;;   (with-eval-after-load 'smtpmail
;;     (add-to-list 'smtpmail-auth-supported 'xoauth2))
;;
;;(set-email-account! "udem"
;;                    '(
;;                      (mu4e-sent-folder       . "/udem/Sent_Mail")
;;                      (mu4e-drafts-folder     . "/udem/Drafts")
;;                      (mu4e-trash-folder      . "/udem/Trash")
;;                      (mu4e-refile-folder     . "/udem/All_Mail")
;;                      (smtpmail-smtp-user     . "kevin.kaiser@umontreal.ca")
;;                      (smtpmail-default-smtp-server . "smtp.office365.com")
;;                      (smtpmail-smtp-server         . "smtp.office365.com")
;;                      (smtpmail-smtp-service . 587)
;;                      (smtpmail-stream-type .  starttls)
;;                      (mu4e-compose-signature . "---\nYours truly\nThe Baz"))
;;                    t)
