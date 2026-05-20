(use-package rust-mode
  :init
  (setq rust-mode-treesitter-derive t))

(use-package rustic
  :after (rust-mode)
  :config
  (setq rustic-format-on-save nil)
  (setq rustic-lsp-client 'eglot)
  :custom
  (rustic-cargo-use-last-stored-arguments t))

(provide 'rust)
