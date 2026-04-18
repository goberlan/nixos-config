;;; functions.el --- Custom utility functions

;;; Commentary:
;; Personal custom functions and utilities

;;; Code:

;; Example: Insert current date
(defun insert-current-date ()
  "Insert current date in YYYY-MM-DD format."
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

;; Example: Reload configuration
(defun reload-emacs-config ()
  "Reload Emacs configuration."
  (interactive)
  (load-file user-init-file)
  (message "Configuration reloaded!"))

;; Add your custom functions below:



;;; functions.el ends here
(defun wj/format-filename-to-snake-case (filename))
(defun go/org-rg-search ()
  "Search org-roam director using consult ripgrepg. With live previe."
  (interactive)
  (let ((consult-ripgrep-command "rg --multiline --null --line-buffered --color=always --max-columns=500 --no-heading --line-number . -e ARG OPTS"))
    (consult-ripgrep org-directory)))
(global-set-key (kbd "C-c o s") 'go/org-rg-search)

;; Yank current file name with line number to clipboard
(defun yank-file-line-to-clipboard ()
  "Yank the current file name with line number to the clipboard.
The format will be: filename:line-number"
  (interactive)
  (let* ((filename (if (buffer-file-name)
                       (file-name-nondirectory (buffer-file-name))
                     (buffer-name)))
         (line-number (line-number-at-pos))
         (file-line-string (format "%s:%d" filename line-number)))
    (kill-new file-line-string)
    (message "Copied to clipboard: %s" file-line-string)))

(defun yank-file-line-full-path-to-clipboard ()
  "Yank the current file's full path with line number to the clipboard.
The format will be: /full/path/to/filename:line-number"
  (interactive)
  (let* ((filename (if (buffer-file-name)
                       (buffer-file-name)
                     (buffer-name)))
         (line-number (line-number-at-pos))
         (file-line-string (format "%s:%d" filename line-number)))
    (kill-new file-line-string)
    (message "Copied to clipboard: %s" file-line-string)))

;; Optional keybindings for yank-file-line functions
;; (global-set-key (kbd "C-c f l") 'yank-file-line-to-clipboard)
;; (global-set-key (kbd "C-c f p") 'yank-file-line-full-path-to-clipboard)


(defun wj-rsync-to-remote ()
  "Rsync current directory or marked directories in dired to a remote location.
Prompts for the remote destination."
  (interactive)
  (let* ((files (dired-get-marked-files nil nil))
         (sources (if files
                      files
                    (list (dired-current-directory))))
         (remote-dest (read-string "Rsync to (user@host:/path/): ")))
    (dolist (source sources)
      (let* ((source-path (directory-file-name source))
             (command (format "rsync -avz --progress %s %s"
                             (shell-quote-argument source-path)
                             (shell-quote-argument remote-dest))))
        (message "Rsyncing %s to %s..." source-path remote-dest)
        (async-shell-command command "*rsync output*")))))


(defun go/gdb-breakpoint-save ()
  (interactive)
  (let* ((file (or (buffer-file-name)
                   (user-error "Buffer not visiting a file")))
         (line (line-number-at-pos))
         (project-root (or (locate-dominating-file file ".git")
                           (read-directory-name "Project root: ")))
         (rel-file (file-relative-name file project-root))
         (bp-str (format "b %s:%d\n" rel-file line))
         (gdbinit1 (expand-file-name "tools/.gdbinit" project-root))
         (gdbinit2 (expand-file-name "tools/.gdbinit-worker" project-root))
         (choice (completing-read
                  "Append breakpoint to: "
                  (list gdbinit1 gdbinit2)
                  nil t)))
    (with-temp-buffer
      (insert bp-str)
      (append-to-file (point-min) (point-max) choice))
    (message "Appended breakpoint: %s" bp-str)))









(provide 'functions)
