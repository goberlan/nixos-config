;;; rust.el --- Rust configuration  -*- lexical-binding: t; -*-

;; Pre-load: must be set before rustic.el is loaded
(setq rustic-lsp-client 'eglot)

;; File-extension trigger (rustic actually already does this via an
;; autoload cookie, so this line is belt-and-suspenders, but harmless)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rustic-mode))

;; Post-load: only runs once rustic.el has actually been required
(with-eval-after-load 'rustic
  (setq rustic-format-on-save t))

(provide 'rust)
