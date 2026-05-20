;; ;; for terminal emacs
;; (use-package clipetty
;;  :ensure t
;;  :hook (after-init . global-clipetty-mode))


(use-package vterm
 :config
 (setq vterm-max-scrollback 5000))


(use-package multi-vterm
 :bind
  ("C-c t n" . multi-vterm)
  ("C-x p t" . multi-vterm-project)
  ("C-c t `" . multi-vterm-dedicated-toggle)
  ("C-c t c" . multi-vterm-dedicated-close)
  ))

(provide 'term-config)
