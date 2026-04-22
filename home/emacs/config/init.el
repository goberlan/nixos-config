;;; -*- lexical-binding: t; -*- 
;; (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; (add-to-list 'load-path (concat user-emacs-directory "lisp"))

;; (add-to-list 'load-path (expand-file-name "~/nixos-config/home/emacs/lisp"))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; (setq bookmark-default-file (expand-file-name "bookmarks" user-emacs-directory))
;; Bookmarks
(setq bookmark-default-file "~/.local/share/emacs/bookmarks")

;; Recentf
(setq recentf-save-file "~/.local/share/emacs/recentf")

;; Savehist
(setq savehist-file "~/.local/share/emacs/history")

;; Backups
(setq backup-directory-alist '(("." . "~/.local/share/emacs/backups")))

;; Auto-save
(setq auto-save-list-file-prefix "~/.local/share/emacs/auto-save-list/.saves-")

;; Project.el
(setq project-list-file "~/.local/share/emacs/projects")

;; Transient (used by magit heavily)
(setq transient-levels-file "~/.local/share/emacs/transient/levels.el")
(setq transient-values-file "~/.local/share/emacs/transient/values.el")
(setq transient-history-file "~/.local/share/emacs/transient/history.el")

;; URL/cache
(setq url-cache-directory "~/.cache/emacs/url/cache")
(setq url-configuration-directory "~/.local/share/emacs/url/")

;; Eshell
(setq eshell-directory-name "~/.local/share/emacs/eshell/")

;; Abbrevs
(setq abbrev-file-name "~/.local/share/emacs/abbrev_defs")

;; Native comp cache
(setq native-comp-eln-load-path
      (list "~/.cache/emacs/eln-cache"))
(require 'builtins nil 'noerror)
;; (require 'theme)
;; (require 'brain)
;; (require 'uxui)
;; (require 'editing)
;; (require 'git)
;; (require 'ai)
;; (require 'dev)
;; (require 'media)
;; (require 'functions)

