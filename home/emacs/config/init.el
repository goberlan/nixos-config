;;; -*- lexical-binding: t; -*-
;; The 'noerror is for nixos
(add-to-list 'load-path (expand-file-name "~/.config/emacs/lisp"))
(require 'use-package)
(setq use-package-always-defer t)
(require 'builtins)
(require 'uxui)
(require 'git)
(require 'organize)
(require 'nix-config)
(require 'term-config)
(require 'rust)
;; (require 'theme)
;; (require 'brain)
;; (require 'uxui)
;; (require 'editing)

;; (require 'ai)
;; (require 'dev)
;; (require 'media)
;; (require 'functions)

