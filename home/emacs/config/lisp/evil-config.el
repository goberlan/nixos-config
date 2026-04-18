
;; (use-package evil
;;   :ensure t
;;   ;; (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
;;   ;; (setq evil-want-keybinding nil)
;;   :config
;;   ;; (evil-set-initial-state 'dired-mode 'emacs)
;;   ;; (evil-set-initial-state 'magit-mode 'emacs)
;;   ;; set leader key in all states
;;   ;;;NOTE(goberlan - 2024-09-16): conflicts with marking
;;   ;; (evil-set-leader nil (kbd "C-SPC"))
;;   ;; set leader key in normal state
;;   (evil-set-leader 'normal (kbd "SPC"))
;;   (setq evil-insert-state-cursor '((bar . 5) "yellow")
;;         evil-normal-state-cursor '(box "purple"))
;;   ;; set local leader
;;   ;; (evil-set-leader 'normal "," t)
;;   (evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
;;   ;; (evil-define-key 'normal 'global (kbd "<leader>.") 'embark-act)
;;   (evil-define-key 'normal 'global (kbd "C-u") 'universal-argument)
;;   ;; (evil-define-key 'insert 'global (kbd "<escape>") 'ignore)
;;   (evil-define-key 'normal 'global (kbd "<leader>p p") 'project-switch-project)
;;   (evil-define-key 'normal 'global (kbd "<leader>r b") 'consult-bookmark)
;;   (evil-define-key 'normal 'global (kbd "<leader>f f") 'find-file)
;;   (evil-define-key 'normal 'global (kbd "<leader>p f") 'project-find-file)
;;   (evil-define-key 'normal 'global (kbd "<leader>p d") 'project-find-dir)
;;   (evil-define-key 'normal 'global (kbd "<leader>p b") 'consult-project-buffer)
;;   (evil-define-key 'normal 'global (kbd "<leader>b") 'consult-buffer)
;;   (evil-mode)
;;   )

;; (use-package evil-collection
;;   :after evil
;;   :ensure t
;;   :config
;;                                         ; if you want to add more to the list
;;                                         ; but this doesn't seem to work
;;   ;; (evil-collection-state-denylist '(evil-magit))
;;   (evil-collection-init))


;; (use-package god-mode
;;   :ensure t)
;; (use-package evil-escape
;;   :config
;;   ;; (setq-default evil-escape-delay 0.1)
;;   ;;(setq-default evil-escape-unordered-key-sequence 1)
;;   (setq-default evil-escape-key-sequence "jj")
;;   (evil-escape-mode))
;; (defun go/insert-custom-comment ()
;;   "Inserts a custom comment based on the current programming mode with the username and date."
;;   (interactive)
;;   (let* ((comment-options '("TODO" "FIXME" "NOTE" "REVIEW"
;;                             "TODO (Versal)" "FIXME (Versal)" "NOTE (Versal)" "REVIEW (Versal)"))
;;          (comment-choice (completing-read "Select comment type: " comment-options))
;;          (comment-start (or comment-start "//")) ; Default to '//' if comment-start fails
;;          (current-date (format-time-string "%Y-%m-%d"))
;;          (is-versal (string-match "(Versal)" comment-choice)) ; Check if "Versal" is included
;;          (base-comment (if is-versal
;;                            (string-remove-suffix " (Versal)" comment-choice) ; Remove " (Versal)"
;;                          comment-choice))) ; Use normal comment type if not Versal
;;     (insert (format "%s%s(%s - %s%s): "
;;                     comment-start
;;                     base-comment
;;                     user-login-name
;;                     current-date
;;                     (if is-versal " - versal" "")))) ; Append " - Versal" if applicable
;;   (evil-append -1))
;; (global-set-key (kbd "C-c i") 'go/insert-custom-comment)
