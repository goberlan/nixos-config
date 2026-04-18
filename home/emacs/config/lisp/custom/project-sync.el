;;; project-sync.el --- Sync between projectile and native project formats -*- lexical-binding: t; -*-

;;; Commentary:
;; This file provides functions to synchronize project lists between
;; projectile format (flat list) and native Emacs project format (nested list).

;;; Code:

(defvar project-sync-projects-file "projects"
  "Path to the native Emacs projects file (nested format).")

(defvar project-sync-projectile-file "projectile.projects"
  "Path to the projectile projects file (flat format).")

(defvar project-sync-merged-file "projects.eld"
  "Path to the merged projects file (flat format).")

(defun project-sync-read-file (file)
  "Read and parse a lisp data file FILE."
  (when (file-exists-p file)
    (with-temp-buffer
      (insert-file-contents file)
      (goto-char (point-min))
      ;; Skip the -*- lisp-data -*- line if present
      (when (looking-at ";;; -\\*- lisp-data -\\*-")
        (forward-line 1))
      (read (current-buffer)))))

(defun project-sync-write-file (file data format)
  "Write DATA to FILE in the specified FORMAT.
FORMAT can be 'flat for projectile format or 'nested for native format."
  (with-temp-file file
    (insert ";;; -*- lisp-data -*-\n")
    (cond
     ((eq format 'flat)
      ;; Projectile format: flat list
      (insert "(")
      (dolist (path data)
        (insert (format "%S " path)))
      (when data
        (backward-delete-char 1)) ; Remove trailing space
      (insert ")"))
     ((eq format 'nested)
      ;; Native format: nested list
      (insert "(\n")
      (dolist (path data)
        (insert (format " (%S)\n" path)))
      (insert ")")))))

(defun project-sync-flatten-paths (nested-list)
  "Convert nested project list to flat list.
Input: ((\"/path1/\") (\"/path2/\"))
Output: (\"/path1/\" \"/path2/\")"
  (mapcar #'car nested-list))

(defun project-sync-nest-paths (flat-list)
  "Convert flat project list to nested list.
Input: (\"/path1/\" \"/path2/\")
Output: ((\"/path1/\") (\"/path2/\"))"
  (mapcar #'list flat-list))

(defun project-sync-merge-unique (list1 list2)
  "Merge two lists removing duplicates, preserving order from list1 first."
  (let ((result (copy-sequence list1)))
    (dolist (item list2)
      (unless (member item result)
        (setq result (append result (list item)))))
    result))

(defun project-sync-normalize-path (path)
  "Normalize project path, expanding ~ to home directory."
  (if (string-prefix-p "~/" path)
      (expand-file-name path)
    path))

(defun project-sync-merge-projects ()
  "Merge projects from both files and update both formats."
  (interactive)
  (let* ((projects-data (project-sync-read-file project-sync-projects-file))
         (projectile-data (project-sync-read-file project-sync-projectile-file))
         (projects-flat (when projects-data
                          (project-sync-flatten-paths projects-data)))
         (projectile-flat (when projectile-data projectile-data))
         ;; Normalize paths
         (projects-normalized (mapcar #'project-sync-normalize-path projects-flat))
         (projectile-normalized (mapcar #'project-sync-normalize-path projectile-flat))
         ;; Merge unique paths
         (merged-paths (project-sync-merge-unique projects-normalized projectile-normalized)))
    
    ;; Write merged file in flat format
    (project-sync-write-file project-sync-merged-file merged-paths 'flat)
    
    ;; Update projects file in nested format
    (project-sync-write-file project-sync-projects-file merged-paths 'nested)
    
    ;; Update projectile file in flat format
    (project-sync-write-file project-sync-projectile-file merged-paths 'flat)
    
    (message "Synchronized %d projects across all files" (length merged-paths))))

(defun project-sync-projects-to-projectile ()
  "Sync from native projects file to projectile format."
  (interactive)
  (let* ((projects-data (project-sync-read-file project-sync-projects-file))
         (projects-flat (when projects-data
                          (project-sync-flatten-paths projects-data)))
         (normalized-paths (mapcar #'project-sync-normalize-path projects-flat)))
    
    (when normalized-paths
      (project-sync-write-file project-sync-projectile-file normalized-paths 'flat)
      (project-sync-write-file project-sync-merged-file normalized-paths 'flat)
      (message "Synced %d projects from native to projectile format" (length normalized-paths)))))

(defun project-sync-projectile-to-projects ()
  "Sync from projectile file to native projects format."
  (interactive)
  (let* ((projectile-data (project-sync-read-file project-sync-projectile-file))
         (normalized-paths (mapcar #'project-sync-normalize-path projectile-data)))
    
    (when normalized-paths
      (project-sync-write-file project-sync-projects-file normalized-paths 'nested)
      (project-sync-write-file project-sync-merged-file normalized-paths 'flat)
      (message "Synced %d projects from projectile to native format" (length normalized-paths)))))

(defun project-sync-status ()
  "Show status of project files."
  (interactive)
  (let* ((projects-data (project-sync-read-file project-sync-projects-file))
         (projectile-data (project-sync-read-file project-sync-projectile-file))
         (merged-data (project-sync-read-file project-sync-merged-file))
         (projects-count (length projects-data))
         (projectile-count (length projectile-data))
         (merged-count (length merged-data)))
    
    (message "Project files status:\n  %s: %d projects\n  %s: %d projects\n  %s: %d projects"
             project-sync-projects-file projects-count
             project-sync-projectile-file projectile-count
             project-sync-merged-file merged-count)))

;; Convenience aliases
(defalias 'sync-projects #'project-sync-merge-projects)
(defalias 'projects-status #'project-sync-status)

(provide 'project-sync)
;;; project-sync.el ends here
