

(defun go/org-rg-search ()
  "Search org-roam directory using consult-ripgrep. With live-preview."
  (interactive)
  (let ((consult-ripgrep-command "rg --multiline --null --line-buffered --color=always --max-columns=500 --no-heading --line-number . -e ARG OPTS"))
    (consult-ripgrep org-directory)))
(global-set-key (kbd "C-c o s") 'go/org-rg-search)

(defun go/dired-chmod-recursive-group-write ()
  "Recursively add group write permissions (chmod -R g+w) to marked files/directories in dired.
If no files are marked, operates on the file at point."
  (interactive)
  (let ((files (dired-get-marked-files)))
    (if files
        (progn
          (when (yes-or-no-p (format "Recursively add group write permissions to %d item(s)? " 
                                   (length files)))
            (dolist (file files)
              (let* ((quoted-file (shell-quote-argument file))
                     (command (format "chmod -R g+w %s" quoted-file))
                     (timestamp (format-time-string "%H:%M:%S"))
                     (buffer-name (format "*chmod-R-g+w-%s*" timestamp)))
                (message "Running chmod -R g+w on %s..." (file-name-nondirectory file))
                (async-shell-command command buffer-name)))
            (revert-buffer))) ; Refresh dired buffer to show updated permissions
      (message "No files marked"))))

;; Bind it to a key in dired mode for convenience
(eval-after-load 'dired
  '(define-key dired-mode-map (kbd "C-c w") 'dired-chmod-recursive-group-write))

(defun go/dired-chmod-recursive (permissions)
  "Recursively apply chmod PERMISSIONS to marked files/directories in dired.
PERMISSIONS should be in chmod format (e.g., 'g+w', '755', 'go-w')."
  (interactive "sEnter chmod permissions (e.g., g+w, 755, go-w): ")
  (let ((files (dired-get-marked-files)))
    (if files
        (progn
          (when (yes-or-no-p (format "Recursively apply chmod %s to %d item(s)? " 
                                   permissions (length files)))
            (dolist (file files)
              (let* ((quoted-file (shell-quote-argument file))
                     (command (format "chmod -R %s %s" permissions quoted-file))
                     (timestamp (format-time-string "%H:%M:%S"))
                     (buffer-name (format "*chmod-R-%s-%s*" permissions timestamp)))
                (message "Running chmod -R %s on %s..." permissions (file-name-nondirectory file))
                (async-shell-command command buffer-name)))
            (revert-buffer))) ; Refresh dired buffer
      (message "No files marked"))))

;; Bind the general function too
(eval-after-load 'dired
  '(define-key dired-mode-map (kbd "C-c C-w") 'dired-chmod-recursive))

(defun go/goto-python-error-at-point ()
  "Parse Python error traceback at point and visit the file at the specified line.
This function looks for patterns like 'File \"/path/to/file.py\", line N' in the
current buffer and opens that file at the specified line."
  (interactive)
  (let ((file-line-regex "File \"\\([^\"]+\\)\", line \\([0-9]+\\)"))
    (save-excursion
      (if (re-search-backward file-line-regex nil t)
          (let ((file-path (match-string 1))
                (line-number (string-to-number (match-string 2))))
            (if (file-exists-p file-path)
                (progn
                  (find-file file-path)
                  (goto-line line-number)
                  (message "Jumped to %s, line %d" file-path line-number))
              (message "File not found: %s" file-path)))
        (if (re-search-forward file-line-regex nil t)
            (let ((file-path (match-string 1))
                  (line-number (string-to-number (match-string 2))))
              (if (file-exists-p file-path)
                  (progn
                    (find-file file-path)
                    (goto-line line-number)
                    (message "Jumped to %s, line %d" file-path line-number))
                (message "File not found: %s" file-path)))
          (message "No Python error traceback found at point"))))))

;; Bind the function to a key (optional)
;; (global-set-key (kbd "C-c C-t g") 'goto-python-error-at-point)

(defun go/open-newest-main-host-log ()
  "Open the main_host.log file from the most recent session directory.
This function finds the newest directory in DRAGONR_ROOT and opens
the internal/main_host.log file within that directory."
  (interactive)
  (let* ((dragonr-root (getenv "DRAGONR_ROOT"))
         (default-directory (if dragonr-root 
                               dragonr-root 
                             (error "DRAGONR_ROOT environment variable not set"))))
    
    ;; Get list of directories sorted by modification time (newest first)
    (let ((dirs (seq-filter 
                 (lambda (f) 
                   (and (file-directory-p f)
                        (not (string-match-p "^\\." (file-name-nondirectory f)))))
                 (directory-files default-directory t))))
      
      (if (null dirs)
          (message "No session directories found in %s" default-directory)
        ;; Sort directories by modification time, newest first
        (let* ((sorted-dirs (sort dirs 
                                 (lambda (a b) 
                                   (time-less-p (nth 5 (file-attributes b))
                                               (nth 5 (file-attributes a))))))
               (newest-dir (car sorted-dirs))
               (log-file (expand-file-name "internal/main_host.log" newest-dir)))
          
          (if (file-exists-p log-file)
              (find-file log-file)
            (message "Log file not found: %s" log-file)))))))

;; Bind the function to a key (optional)
(global-set-key (kbd "C-c C-x o") 'open-newest-main-host-log)
;; i should bind C-x C-S-f to ripgrep current directory file
(defun go/open-main-host-log-find-error ()
  "Open the main_host.log file from the most recent session directory and jump to the first error.
This function finds the newest directory in DRAGONR_ROOT, opens the internal/main_host.log file,
and positions the cursor at the first occurrence of an error message using case-sensitive search."
  (interactive)
  (let* ((dragonr-root (getenv "DRAGONR_ROOT"))
         (default-directory (if dragonr-root 
                               dragonr-root 
                             (error "DRAGONR_ROOT environment variable not set")))
         ;; Save the current case-fold-search value to restore it later
         (old-case-fold-search case-fold-search))
    
    ;; Get list of directories sorted by modification time (newest first)
    (let ((dirs (seq-filter 
                 (lambda (f) 
                   (and (file-directory-p f)
                        (not (string-match-p "^\\." (file-name-nondirectory f)))))
                 (directory-files default-directory t))))
      
      (if (null dirs)
          (message "No session directories found in %s" default-directory)
        ;; Sort directories by modification time, newest first
        (let* ((sorted-dirs (sort dirs 
                                 (lambda (a b) 
                                   (time-less-p (nth 5 (file-attributes b))
                                               (nth 5 (file-attributes a))))))
               (newest-dir (car sorted-dirs))
               (log-file (expand-file-name "internal/main_host.log" newest-dir)))
          
          (if (file-exists-p log-file)
              (progn
                (find-file log-file)
                ;; Go to beginning of buffer
                (goto-char (point-min))
                
                ;; Set case-sensitive search
                (setq case-fold-search nil)
                
                ;; Search for error patterns
                (if (or (search-forward "ERROR" nil t)
                        (search-forward "Error" nil t)
                        (search-forward "error" nil t)
                        (search-forward "Exception" nil t)
                        (search-forward "Traceback" nil t))
                    (progn
                      ;; Go to the beginning of the line with the error
                      (beginning-of-line)
                      (message "Found error in log file"))
                  (message "No errors found in log file"))
                
                ;; Restore original case-fold-search setting
                (setq case-fold-search old-case-fold-search))
            (message "Log file not found: %s" log-file)))))))

;; (defun qgenie-ask (param)
;;   "Call 'qgenie ask' with PARAM and insert the output at point."
;;   (interactive "sAsk qgenie: ")
;;   (let ((output (shelTest received! How can I assist you today?
;; l-command-to-string (concat "qgenie ask " (shell-quote-argument param)))))
;;     (insert output)))



(defun go/copy-vim-file-path-and-line ()
  "Copy the current buffer's absolute file path and line number to clipboard in vim format.
   Format: vim <absolute_file_path> +line_number"
  (interactive)
  (let* ((filename (buffer-file-name))
         (line-number (line-number-at-pos))
         (vim-command (if filename
                          (format "vim %s +%d" (expand-file-name filename) line-number)
                        (error "Buffer is not visiting a file"))))
    ;; Copy to kill ring (which syncs with clipboard)
    (kill-new vim-command)
    (message "Copied to clipboard: %s" vim-command)))

;; Optional: Bind to a key
;; (global-set-key (kbd "C-c v") 'copy-vim-file-path-and-line)

(defun go/cpp-convert-assignment-to-direct-init ()
  "Convert C++ assignment initialization to direct initialization.
   Changes 'var = value' to 'var{value}' on the current line."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (when (re-search-forward "\\([[:alnum:]_]+\\)\\s-*=\\s-*\\(.+\\);" (line-end-position) t)
      (replace-match "\\1{\\2};" nil nil))))

(defun go/cpp-convert-all-assignment-to-direct-init ()
  "Convert all C++ assignment initializations to direct initialization in buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\([[:alnum:]_]+\\)\\s-*=\\s-*\\([^;]+\\);" nil t)
      (replace-match "\\1{\\2};" nil nil))))

(defun go/cpp-convert-direct-init-to-assignment ()
  "Convert C++ direct initialization to assignment initialization.
Changes 'var{value}' to 'var = value' on the current line or multiline statement."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (when (re-search-forward "\\([[:alnum:]_:]+\\s-+\\)?\\([[:alnum:]_]+\\)\\s-*{" nil t)
      (let ((var-name (match-string 2))
            (var-start (match-beginning 0))
            (brace-start (match-end 0)))
        (backward-char 1) ; go back to the opening brace
        (forward-sexp 1)  ; find matching closing brace
        (when (looking-at "\\s-*;")
          (let ((brace-end (1- (point)))
                (semicolon-end (match-end 0))
                (content (buffer-substring brace-start (1- (point)))))
            (delete-region var-start semicolon-end)
            (insert (format "%s = %s;" var-name content))))))))

(defun go/sync-dragonr-docs-and-workflows ()
  "Copy doc directory and .github/workflows from compiler/master to rumi_doctor.
This function copies:
- /local/mnt/workspace/goberlan/dragonr/compiler/master/doc -> /local/mnt/workspace/goberlan/dragonr/rumi_doctor/doc
- /local/mnt/workspace/goberlan/dragonr/compiler/master/.github/workflows -> /local/mnt/workspace/goberlan/dragonr/rumi_doctor/.github/workflows"
  (interactive)
  (let ((source-doc "/local/mnt/workspace/goberlan/dragonr/compiler/master/doc")
        (dest-doc "/local/mnt/workspace/goberlan/dragonr/rumi_doctor/doc")
        (source-workflows "/local/mnt/workspace/goberlan/dragonr/compiler/master/.github/workflows")
        (dest-workflows "/local/mnt/workspace/goberlan/dragonr/rumi_doctor/.github/workflows"))
    
    ;; Check if source directories exist
    (unless (file-directory-p source-doc)
      (error "Source doc directory does not exist: %s" source-doc))
    (unless (file-directory-p source-workflows)
      (error "Source workflows directory does not exist: %s" source-workflows))
    
    ;; Confirm with user before proceeding
    (when (yes-or-no-p "Sync DragonR docs and workflows from compiler/master to rumi_doctor? ")
      (message "Starting sync of DragonR docs and workflows...")
      
      ;; Copy doc directory using synchronous shell-command
      (let ((doc-command (format "rsync -av --delete %s/ %s/" 
                                (shell-quote-argument source-doc)
                                (shell-quote-argument dest-doc))))
        (message "Copying doc directory...")
        (let ((doc-result (shell-command doc-command)))
          (if (= doc-result 0)
              (message "✓ Doc directory sync completed successfully")
            (error "✗ Doc directory sync failed with exit code %d" doc-result))))
      
      ;; Copy workflows directory using synchronous shell-command
      (let ((workflows-command (format "rsync -av --delete %s/ %s/" 
                                      (shell-quote-argument source-workflows)
                                      (shell-quote-argument dest-workflows))))
        (message "Copying workflows directory...")
        (let ((workflows-result (shell-command workflows-command)))
          (if (= workflows-result 0)
              (message "✓ Workflows directory sync completed successfully")
            (error "✗ Workflows directory sync failed with exit code %d" workflows-result))))
      
      (message "✓ DragonR sync completed successfully! Both doc and workflows directories have been synced."))))

;; Optional: Bind to a key for easy access
;; (global-set-key (kbd "C-c d s") 'go/sync-dragonr-docs-and-workflows)

;;; Org-mode refile functions

(defun go/org-refile-to-end-of-file (arg)
  "Refile current heading to a location from cursor position to end of file.
If prefix ARG, copy instead of move."
  (interactive "P")
  (unless (derived-mode-p 'org-mode)
    (user-error "Not in an org-mode buffer"))
  (let* ((current-pos (point))
         (file (buffer-file-name (buffer-base-buffer)))
         (org-refile-targets nil)
         (org-refile-use-outline-path 'file)
         (org-refile-keep arg)
         current-prefix-arg)
    ;; Collect all headings from current position to end of file
    (save-excursion
      (goto-char current-pos)
      (while (re-search-forward org-heading-regexp nil t)
        (let* ((heading-pos (point))
               (level (org-outline-level)))
          ;; Add this heading as a refile target
          (setq org-refile-targets
                (cons (cons file (cons :maxlevel 10))
                      org-refile-targets)))))
    ;; If no targets found, error out
    (unless org-refile-targets
      (user-error "No headings found from cursor to end of file"))
    ;; Call org-refile with our custom targets
    (call-interactively #'org-refile)))

(defun go/org-refile-list-item-to-end-of-file (arg)
  "Refile current list item to any heading in the file.
If prefix ARG, copy instead of move. Works with plain list items including checkboxes."
  (interactive "P")
  (unless (derived-mode-p 'org-mode)
    (user-error "Not in an org-mode buffer"))
  (unless (org-at-item-p)
    (user-error "Not at a list item"))
  (let* ((current-pos (point))
         (item-beg (save-excursion (org-beginning-of-item) (point)))
         (item-end (save-excursion (org-end-of-item) (point)))
         (item-text (buffer-substring-no-properties item-beg item-end))
         (current-heading-pos (save-excursion (org-back-to-heading t) (point)))
         (targets nil))
    ;; Collect all headings in the file
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward org-heading-regexp nil t)
        (save-excursion
          (beginning-of-line)
          (let* ((heading-pos (point))
                 (heading-text (org-get-heading t t t t)))
            ;; Don't include the current heading that contains this list item
            (unless (= heading-pos current-heading-pos)
              (push (cons heading-text heading-pos) targets))))))
    ;; If no targets found, error out
    (unless targets
      (user-error "No other headings found in file"))
    ;; Reverse to maintain file order
    (setq targets (nreverse targets))
    ;; Let user select target
    (let* ((target-heading (completing-read "Refile to: " 
                                           (mapcar #'car targets)
                                           nil t))
           (target-pos (cdr (assoc target-heading targets))))
      ;; Copy or kill the item
      (unless arg
        (delete-region item-beg item-end))
      ;; Go to target and insert
      (goto-char target-pos)
      (org-end-of-subtree t t)
      (unless (bolp) (insert "\n"))
      (insert item-text)
      (unless (string-suffix-p "\n" item-text)
        (insert "\n"))
      (message "%s list item to: %s" 
               (if arg "Copied" "Moved")
               target-heading))))
