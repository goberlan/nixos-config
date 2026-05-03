(use-package emacs
  :init
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
  (auto-save-mode)
  (setq use-package-always-ensure t)
  (load-theme 'modus-vivendi-tinted)
  ;; (fido-vertical-mode 1)
  (recentf-mode 1)
  ;; better ergonomics
  (repeat-mode)

  (setq request-log-level 'blather)
  (setq xref-search-program 'ripgrep)
  (setq request-message-level 'blather)
  ;; It lets you use a new minibuffer when you're in the minibuffer
  (setq enable-recursive-minibuffers t)
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
  (setq-default indent-tabs-mode nil)
  ;; is only per buffer
  ;; https://emacs.stackexchange.com/a/72634
  ;; (setq indent-tabs-mode nil)
  ;; If this doesn't set the font, you need to prevent emacs from loading ~/.Xresources
  ;; by putting this in your early-init.el: (setq inhibit-x-resources t)
  ;; (add-to-list 'Info-additional-directory-list "/prj/qct/sve/dragonr2/tools/opt/sles12/share/man")
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
  (hs-minor-mode)
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
(use-package ansi-color
  :hook (compilation-filter . ansi-color-compilation-filter))

(use-package which-key
  :config
  (which-key-mode))

(use-package savehist
 :init
 (savehist-mode))


(provide 'builtins)
