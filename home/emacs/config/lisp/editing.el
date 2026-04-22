(use-package super-save
  :config
  (super-save-mode +1))

(use-package paredit
  :hook (elisp-mode . paredit-mode))
(provide 'editing)
