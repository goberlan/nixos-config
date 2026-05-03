(use-package magit
  :custom
  (magit-log-margin '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18)))


;; (use-package forge
;;   :after magit)

;; ;; This works for ssh agency keys
;; ;; It will prompt on the first push, but not on the others. Nice.
;; (use-package ssh-agency
;;   :after magit)

;; (use-package notmuch)
;; (use-package pr-review
;;  :config
;;  (setq pr-review-ghub-host "github.com")
;;  (setq pr-review-ghub-username "whompyjaw"))


;; (use-package git-link
;;   :bind
;;   ("C-c g d" . git-link-dispatch)
;;   ("C-c g h" . git-link-homepage)
;;   ("C-c g c" . git-link-commit)
;;   ("C-c g l" . git-link))

;; ;;(use-package agitate
;; ;;  :hook
;; ;;  (diff-mode-hook . agitate-diff-enable-outline-minor-mode)
;; ;;  :config
;; ;;  ;; These are all OPTIONAL.  You should just use whatever key bindings
;; ;;  ;; or setup you prefer.
;; ;;
;; ;;  ;; Agitate is still a WORK-IN-PROGRESS.
;; ;;  (advice-add #'vc-git-push :override #'agitate-vc-git-push-prompt-for-remote)
;; ;;
;; ;;  ;; Also check: `agitate-log-edit-informative-show-files',
;; ;;  ;; `agitate-log-edit-informative-show-root-log'.
;; ;;  (agitate-log-edit-informative-mode 1)
;; ;;
;; ;;  (let ((map global-map))
;; ;;    (define-key map (kbd "C-x v =") #'agitate-diff-buffer-or-file) ; replace `vc-diff'
;; ;;    (define-key map (kbd "C-x v g") #'agitate-vc-git-grep) ; replace `vc-annotate'
;; ;;    (define-key map (kbd "C-x v f") #'agitate-vc-git-find-revision)
;; ;;    (define-key map (kbd "C-x v s") #'agitate-vc-git-show)
;; ;;    (define-key map (kbd "C-x v p p") #'agitate-vc-git-format-patch-single)
;; ;;    (define-key map (kbd "C-x v p n") #'agitate-vc-git-format-patch-n-from-head))
;; ;;  (let ((map diff-mode-map))
;; ;;    (define-key map (kbd "C-c C-b") #'agitate-diff-refine-cycle) ; replace `diff-refine-hunk'
;; ;;    (define-key map (kbd "C-c C-n") #'agitate-diff-narrow-dwim))
;; ;;  (let ((map log-view-mode-map))
;; ;;    (define-key map (kbd "w") #'agitate-log-view-kill-revision)
;; ;;    (define-key map (kbd "W") #'agitate-log-view-kill-revision-expanded))
;; ;;  (let ((map vc-git-log-view-mode-map))
;; ;;    (define-key map (kbd "c") #'agitate-vc-git-format-patch-single))
;; ;;  (let ((map log-edit-mode-map))
;; ;;    (define-key map (kbd "C-c C-i C-n") #'agitate-log-edit-insert-file-name)
;; ;;    ;; See user options `agitate-log-edit-emoji-collection' and
;; ;;    ;; `agitate-log-edit-conventional-commits-collection'.
;; ;;    (define-key map (kbd "C-c C-i C-e") #'agitate-log-edit-emoji-commit)
;; ;;    (define-key map (kbd "C-c C-i C-c") #'agitate-log-edit-conventional-commit)))

(provide 'git)
