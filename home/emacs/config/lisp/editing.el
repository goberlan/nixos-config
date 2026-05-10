(use-package hi-lock
  :defer t
  ;; :init (add-hook 'some-hook 'hi-lock-mode)
  ;; :config (use-package my-hi-lock)
  :bind (("M-o l" . highlight-lines-matching-regexp)
         ("M-o r" . highlight-regexp)
         ("M-o w" . highlight-phrase)))

(use-package super-save
  :config
  (super-save-mode +1))

(use-package paredit
  :hook (elisp-mode . paredit-mode))
(provide 'editing)
