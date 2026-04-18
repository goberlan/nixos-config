(use-package gptel
  :bind (("C-c C-<return>" . gptel-menu)
         ("C-c <return>" . gptel-send)
         ("C-c j" . gptel-menu)
         ("C-c C-g" . gptel-abort)))
;;   :config
;; (gptel-make-tool "Claude"
;;                  :key #'gptel-api-key-from-auth-source
;;                  :stream t))

;; (use-package mcp
;;   :ensure t
;;   :after gptel
;;   :custom (mcp-hub-servers
;;            `(("filesystem" . (:command "npx" :args ("-y" "@modelcontextprotocol/server-filesystem" "/home/lizqwer/MyProject/")))
;;              ("fetch" . (:command "uvx" :args ("mcp-server-fetch")))
;;              ("qdrant" . (:url "http://localhost:8000/sse"))
;;              ("graphlit" . (
;;                             :command "npx"
;;                             :args ("-y" "graphlit-mcp-server")
;;                             :env (
;;                                   :GRAPHLIT_ORGANIZATION_ID "your-organization-id"
;;                                   :GRAPHLIT_ENVIRONMENT_ID "your-environment-id"
;;                                   :GRAPHLIT_JWT_SECRET "your-jwt-secret")))))
;;   :config (require 'mcp-hub)
;;   :hook (after-init . mcp-hub-start-all-server))

(provide 'ai)
