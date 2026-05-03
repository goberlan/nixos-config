;;; early-init.el --- -*- lexical-binding: t -*-
;; Copied from: https://github.com/alexluigit/emacs-grandview/blob/29c95e34e134527da326c99b09688fa85da6d492/early-init.el
;; (when (and (>= emacs-major-version 28) (native-comp-available-p))
;;   (setq native-comp-eln-load-path
;;         (or (and (getenv "EMACSNATIVELOADPATH") native-comp-eln-load-path)
;;             (append (list (expand-file-name "~/.cache/emacs/eln-cache/"))
;;                     (delete (expand-file-name "eln-cache/" user-emacs-directory)
;;                             native-comp-eln-load-path)))
;;         native-comp-async-report-warnings-errors 'silent))
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")) ; No littering

(setq
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
