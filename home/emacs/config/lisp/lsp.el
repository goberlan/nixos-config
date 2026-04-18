;(use-package eglot
;  :ensure t
;  :config
;  (add-to-list 'eglot-server-programs '(
;                                        (python-mode python-ts-mode)
;                                        "basedpyright-langserver" "--stdio"
;                                        ))
;  (setq-default
;   eglot-workspace-configuration
;   '(:basedpyright (
;                    :typeCheckingMode "recommended"
;                    )
;                   :basedpyright.analysis (
;                                           :diagnosticSeverityOverrides (
;                                                                         :reportUnusedCallResult "none"
;                                                                         )
;                                           :inlayHints (
;                                                        :callArgumentNames :json-false
;                                                        )
;                                           )))
;  )

;; (use-package eglot
;;   :bind (:map eglot-mode-map
;; 	      ("C-c e d" . eldoc)
;; 	      ("C-c e r" . eglot-rename)
;; 	      ;; ("C-c C-o" . python-sort-imports)
;; 	      ("C-c e f" . eglot-format-buffer))
;;   ;; Might be a way to disably flymake: https://github.com/joaotavora/eglot/issues/123
;;   ;; ('eglot--managed-mode-hook (lambda () (flymake-mode -1)))
;;   :config
;;   (setq eglot-ignored-server-capabilities '(:hoverProvider))
;;   (setq eglot-ignored-server-capabilities '(:inlayHintProvider))
;;   (fset #'jsonrpc--log-event #'ignore)
;;   (add-to-list 'eglot-server-programs '(
;;                                         (python-mode python-ts-mode)
;;                                         "basedpyright-langserver" "--stdio"
;;                                         )))
;; ;; these configs were kind of fucky
;; (setq-default
;;  eglot-workspace-configuration
;;  '(:basedpyright
;;    ;;(
;;    ;;                  :typeCheckingMode "recommended"
;;    ;;                  )
;;    (:basedpyright.analysis (
;;                            :diagnosticSeverityOverrides (
;;                                                          :reportUnusedCallResult "none"
;;                                                          )
;;                            :inlayHints (
;;                                         :callArgumentNames :json-false
;;                                         )
;;                            )))
;; )

;; :hook
;; (python-ts-mode . eglot-ensure))
;; (use-package eglot
;;   :ensure t
;;   :config
;;   (add-to-list 'eglot-server-programs '(python-mode . ("pylsp")))

;;   (setq-default eglot-workspace-configuration
;;                 '((:pylsp . (:configurationSources ["flake8"] :plugins (:pycodestyle (:enabled nil) :mccabe (:enabled nil) :flake8 (:enabled t))))))

;;   :hook
;;   ((python-ts-mode . eglot-ensure)))

;; (use-package eglot-booster
;;   ;; :straight (eglot-booster :type git :host github :repo "jdtsmith/eglot-booster")
;;   :after eglot
;;   :config (eglot-booster-mode))
