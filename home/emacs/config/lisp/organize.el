(use-package org
  :ensure t
  :bind (("C-c a" . org-agenda)
	 ("C-c c"  . org-capture)
	 ("C-c l" . org-store-link)
	 ("C-c b" . org-iswitchb)
	 :map org-mode-map
	 ("C-c k" . org-cut-subtree))
  :config
  ;; (add-to-list
  ;;  'org-src-lang-modes '("plantuml" . plantuml))
  ;; (org-babel-do-load-languages
  ;;  'org-babel-load-languages
  ;;  '((plantuml . t)
  ;;    (C . t)
  ;;    (shell . t)))
  (setq org-agenda-dim-blocked-tasks nil)

  :custom
  (org-directory "~/files/org")
  (org-capture-templates
   '(("t" "todo" entry (file+headline "refile.org" "Tasks")
      "* TODO %t %?")
     ("n" "note" entry (file+headline "refile.org" "Notes")
      "* NOTE %?")
     ("m" "meeting" entry (file+olp+datetree "meetings.org")
      "* %?")
     ("j" "journal" entry (file+olp+datetree "journal.org")
      "* %?")))
  (org-agenda-span 14)
  (org-agenda-files (list org-directory))
  (org-refile-targets '((nil :maxlevel . 4)
			(org-agenda-files :maxlevel . 4)))
					; create a new parent node in that file
  (org-refile-allow-creating-parent-nodes 'confirm)
					; This adds the filename as a choice
  (org-refile-use-outline-path 'file)
					; This adds the /Tasks /Notes after the filename
  (org-outline-path-complete-in-steps nil)
  (org-todo-keywords
   '((sequence "TODO(t)" "DOING(i)" "PENDING(p)" "MEETING(m)" "|" "DONE(d)" "CANCELLED(c)")))
  )

;; (use-package org-roam
;;   :custom
;;   (org-roam-directory "~/files/org/roam")
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n g" . org-roam-graph)
;;          ("C-c n t" . org-roam-dailies-goto-today)
;;          ("C-c n i" . org-roam-node-insert)
;;          ("C-c n c" . org-roam-capture)
;;          ;; Dailies
;;          ("C-c n j" . org-roam-dailies-capture-today))
;;   :config
;;   ;; If you're using a vertical completion framework, you might want a more informative completion interface
;;   (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
;;   (setq org-roam-dailies-capture-templates
;;         '(("d" "default" entry
;;            "* %?"
;;            :target (file+datetree "daily.org" week))))
;;   (org-roam-db-autosync-mode)
;;   ;; If using org-roam-protocol
;;   (require 'org-roam-protocol))

;(use-package htmlize
;  :ensure t)

;;(use-package simple-httpd)


(provide 'organize)
