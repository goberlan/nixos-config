(use-package emacs
  :init
  ;; Copied from: https://github.com/alexluigit/emacs-grandview/blob/29c95e34e134527da326c99b09688fa85da6d492/early-init.el
  ;; (when (and (>= emacs-major-version 28) (native-comp-available-p))
  ;;   (setq native-comp-eln-load-path
  ;;         (or (and (getenv "EMACSNATIVELOADPATH") native-comp-eln-load-path)
  ;;             (append (list (expand-file-name "~/.cache/emacs/eln-cache/"))
  ;;                     (delete (expand-file-name "eln-cache/" user-emacs-directory)
  ;;                             native-comp-eln-load-path)))
  ;;         native-comp-async-report-warnings-errors 'silent))
  (setq
   user-emacs-directory (expand-file-name "~/.cache/emacs/")
   custom-file (concat user-emacs-directory "custom.el") ; Place all "custom" code in a temporary file
   bookmark-default-file (concat user-emacs-directory "bookmarks")
   package-user-dir (concat user-emacs-directory "elpa")
   backup-directory-alist '(("." . (concat user-emacs-directory "backups")))
   native-comp-eln-load-path
   (list (concat user-emacs-directory "eln-cache"))
   gc-cons-threshold most-positive-fixnum ; Inhibit garbage collection during startup
   gc-cons-threshold 80000000 ;; original value * 100
   package-quickstart nil ; Prevent package.el loading packages prior to their init-file
   package-enable-at-startup nil
   ad-redefinition-action 'accept ; Disable warnings from legacy advice system
   inhibit-startup-message t ; Reduce noise at startup
   inhibit-startup-echo-area-message user-login-name
   ;; not really sure what this does. disables something
   ;; inhibit-default-init t
   inhibit-startup-screen t
   initial-scratch-message nil
   auto-mode-case-fold nil ; Use case-sensitive `auto-mode-alist' for performance
   fast-but-imprecise-scrolling t ; More performant rapid scrolling over unfontified regions
   ffap-machine-p-known 'reject ; Don't ping things that look like domain names
   ;; ;;  frame-inhibit-implied-resize t ; Inhibit frame resizing for performance
   ;; ;;  idle-update-delay 1.0  ; slow down UI updates down
   ;; ;;  inhibit-compacting-font-caches t ; Inhibit frame resizing for performance
   ;; ;;  read-process-output-max (* 1024 1024) ; Increase how much is read from processes in a single chunk.
   ;; ;;  redisplay-skip-fontification-on-input t ; Inhibits it for better scrolling performance.
   command-line-x-option-alist nil ; Remove irreleant command line options for faster startup
   select-active-regions 'only ; Emacs hangs when large selections contain mixed line endings.
   auto-save-list-file-prefix nil
   create-lockfiles nil
   make-backup-files nil
   vc-follow-symlinks t ; Do not ask about symlink following
   use-short-answers t ; y/n for yes/no
   inhibit-x-resources t
   ;; safe-local-variable-values
   ;; '((eval . (ignore-errors (grandview-setup-literate-file))))
   )


  ;; to prevent breaking font
  ;; this works on my linuxview (makes emacs use gnu's default backup font)
  (tool-bar-mode 0)                    ; Disable toolbar ; for emacs 30
  (tooltip-mode 0)                     ; Disable tooltips
  (menu-bar-mode 0)                    ; Disable menu bar
  (scroll-bar-mode 0)

  ;; not needed for nixos
  ;; (require 'package)
  ;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  ;; (add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/"))
  ;; (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
  ;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  ;; (package-initialize)
  ;; TAB cycle if there are only few candidates
  ;; (setq completion-cycle-threshold 2)
  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)
  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete)
  :bind
  ("C-x C-b" . ibuffer)
  ;; ("C-c g" . grep-find)
  ("C-x 4 M-b" . bookmark-jump-other-window)
  ("C-x 5 M-b" . bookmark-jump-other-frame)
  ("C-c s" . scratch-buffer)
  ("M-z" . zap-up-to-char)
  ("C-M-z" . zap-to-char)
  ("C-x t `" . tab-recent)
  ("C-x f" . recentf)
  (:map emacs-lisp-mode-map
        ("C-c m e b" . eval-buffer))
  ;; (:map dired-mode-map
  ;;       ("C" . dired-async-do-copy))
  ;; ;; didn't work
  ;; (:map dired-mode-map
  ;;       ("<normal-state> SPC" . nil))

  :config
  (setq
   request-log-level 'blather
   selection-coding-system 'utf-8
   xref-search-program 'ripgrep
   request-message-level 'blather
  ;; It lets you use a new minibuffer when you're in the minibuffer
   enable-recursive-minibuffers t)
  (auto-save-mode)
  (load-theme 'modus-vivendi-tinted)
  ;; (fido-vertical-mode 1)
  (recentf-mode 1)
  (which-key-mode)
  (savehist-mode)
  ;; better ergonomics
  (repeat-mode)


  (add-to-list 'default-frame-alist '(fullscreen . maximized))
  (setq-default indent-tabs-mode nil)
  ;; is only per buffer
  ;; https://emacs.stackexchange.com/a/72634
  ;; (setq indent-tabs-mode nil)
  ;; If this doesn't set the font, you need to prevent emacs from loading ~/.Xresources
  ;; by putting this in your early-init.el: (setq inhibit-x-resources t)
  ;; This adds font for emacs clients when emacs daemon is used
  ;; (add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font Propo-12"))
  ;; This one loaded faster, but doesn't work for emacsclient when you use emacs daemon
  ;; (set-frame-font "JetBrainsMonoNL Nerd Font Propo-12")
  (set-default-coding-systems 'utf-8)

  (keymap-global-unset "C-z")

  ;;TODO: figure out how to make these turn off when a certain mode is called (they are extra keybinds)
  ;;(keymap-unset hs-minor-mode-map "C-c @ C-M-h")
  ;;(kemap-unset hs-minor-mode-map "C-M-h")
  (windmove-mode)
  ;; (hs-minor-mode)
  (windmove-default-keybindings 'meta)

  :custom
  (c-electric-flag nil)
  (dired-dwim-target t)
  (indent-tabs-mode nil)
  (warning-minimum-level :error)
  (native-comp-async-report-warnings-errors 0)
  (bookmark-version-control 'never)
  (dired-auto-revert-buffer t)

  ;; this may cause slowness for emacs if the file is huge
  (global-auto-revert-mode t)
  ;; this was in my other init.el, not sure if i need this...
  ;; I think this allows you to set the way the line numbers
  ;; are displayed (relative, absolute, etc)
  ;; (display-line-numbers t)
  (display-line-numbers-type 'visual)
  (global-display-line-numbers-mode t)
  (auth-sources '("~/.authinfo"))
  ;; this is not needed when using orderless
  ;; (completion-styles '(flex basic partial-completion emacs22))
  (history-delete-duplicates t)
  ;; (auto-save-list-file-prefix (user-data "auto-save-list/.saves-"))
  (inhibit-startup-screen t)
  
  (kill-do-not-save-duplicates t)
  (kill-ring-max 200)
  (bookmark-save-flag 1)
  (confirm-kill-emacs 'y-or-n-p)
  (vc-follow-symlinks t)
  (initial-scratch-message nil)
  (use-short-answers t)
  (ring-bell-function 'ignore)

  :custom-face
  (cursor ((t (:background "#FF9B00"))))
  )
;; adds color to compilation and removes ansi escape sequences (letters w/ brackets)
;; (use-package ansi-color
;;   :hook (compilation-filter . ansi-color-compilation-filter))

(provide 'builtins)
