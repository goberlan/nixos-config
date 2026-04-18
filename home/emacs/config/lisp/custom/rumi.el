(defun rumi-ssh-command (system-number)
  "Run rumi_fw command on a RUMI system via SSH.
SYSTEM-NUMBER is the system identifier (e.g., 1, 2, 3, etc.)."
  (interactive "sEnter RUMI system number: ")
  (let* ((host (format "san-r5v-0000%s" system-number))
         (password-file (expand-file-name "/usr2/goberlan/.rumi_pw"))
         (ssh-opts "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa -o PubkeyAcceptedKeyTypes=ssh-rsa")
         (remote-command "cd /media/card/infra/leithfw &&./rumi_fw -cll debug -bp board_params.xml -bc board_config/Rumi51-R32v.xml")
         (full-command (format "sshpass -f %s ssh %s root@%s \"%s\""
                              password-file
                              ssh-opts
                              host
                              remote-command)))
    (if (file-exists-p password-file)
        (progn
          (message "Running command on %s..." host)
          (async-shell-command full-command (format "*RUMI-%s*" system-number)))
      (error "Password file %s not found" password-file))))


(defun rumi-ssh-command-named-buffer (system-number)
  "Run rumi_fw command on a RUMI system via SSH.
SYSTEM-NUMBER is the system identifier (e.g., 1, 2, 3, etc.)."
  (interactive "sEnter RUMI system number: ")
  (let* ((host (format "san-r5v-0%s" system-number))
         (password-file (expand-file-name "~/.rumi_pw"))
         (ssh-opts "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa -o PubkeyAcceptedKeyTypes=ssh-rsa")
         (remote-command "cd /media/card/infra && ./rumi_fw -cll debug -bp board_params.xml -bc board_config/Rumi51-R32v.xml")
         (timestamp (format-time-string "%H:%M:%S"))
         (buffer-name (format "*rumi-fw-%s-%s*" system-number timestamp))
         (full-command (format "sshpass -f %s ssh %s root@%s \"%s\""
                              password-file
                              ssh-opts
                              host
                              remote-command)))
    (if (file-exists-p password-file)
        (progn
          (message "Running rumi_fw on %s... (output in %s)" host buffer-name)
          (async-shell-command full-command buffer-name))
      (error "Password file %s not found" password-file))))




(defun rumi-ssh-custom-command (system-number command)
  "Run a custom command on a RUMI system via SSH.
SYSTEM-NUMBER is the system identifier.
COMMAND is the command to run on the remote system."
  (interactive "sEnter RUMI system number: \nsEnter command to run: ")
  (let* ((host (format "san-r5v-0000%s" system-number))
         (password-file (expand-file-name "/usr2/goberlan/.rumi_pw"))
         (ssh-opts "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa -o PubkeyAcceptedKeyTypes=ssh-rsa")
         (remote-command (format "cd /media/card/infra && %s" command))
         (full-command (format "sshpass -f %s ssh %s root@%s \"%s\""
                              password-file
                              ssh-opts
                              host
                              remote-command)))
    (if (file-exists-p password-file)
        (progn
          (message "Running '%s' on %s..." command host)
          (async-shell-command full-command (format "*RUMI-%s*" system-number)))
      (error "Password file %s not found" password-file))))

(defun rumi-scp-custom-command (system-number command)
  "Run a custom command on a RUMI system via SSH.
SYSTEM-NUMBER is the system identifier.
COMMAND is the command to run on the remote system."
  (interactive "sEnter RUMI system number: \nsEnter command to run: ")
  (let* ((host (format "san-r5v-0000%s" system-number))
         (password-file (expand-file-name "/usr2/goberlan/.rumi_pw"))
         (ssh-opts "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa -o PubkeyAcceptedKeyTypes=ssh-rsa")
         (remote-command (format "cd /media/card/infra && %s" command))
         (full-command (format "sshpass -f %s ssh %s root@%s \"%s\""
                              password-file
                              ssh-opts
                              host
                              remote-command)))
    (if (file-exists-p password-file)
        (progn
          (message "Running '%s' on %s..." command host)
          (async-shell-command full-command (format "*RUMI-%s*" system-number)))
      (error "Password file %s not found" password-file))))


(defun rumi-fw-debug (system-number &optional board-config)
  "Run rumi_fw debug command on a RUMI system.
SYSTEM-NUMBER is the system identifier.
BOARD-CONFIG is optional board config file (defaults to Rumi51-R32v.xml)."
  (interactive "sEnter RUMI system number: \nsBoard config (default: Rumi51-R32v.xml): ")
  (let ((config (if (string-empty-p board-config)
                    "board_config/Rumi51-R32v.xml"
                  board-config)))
    (rumi-ssh-custom-command system-number
                            (format "./rumi_fw -cll debug -bp board_params.xml -bc %s" config))))


;; (defun dired-scp-to-rumi (system-number &optional remote-path)
;;   "SCP marked files or file at point to a RUMI system.
;; SYSTEM-NUMBER is the system identifier (e.g., 1, 2, 3, etc.).
;; REMOTE-PATH is optional destination path (defaults to /media/card/infra/)."
;;   (interactive "sEnter RUMI system number: \nsRemote path (default: /media/card/infra/): ")
;;   (let* ((files (or (dired-get-marked-files) 
;;                    (list (dired-get-filename))))
;;          (host (format "san-r5v-0000%s" system-number))
;;          (password-file (expand-file-name "~/.rumi_pw"))
;;          (ssh-opts "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa -o PubkeyAcceptedKeyTypes=ssh-rsa")
;;          (dest-path (if (string-empty-p remote-path) 
;;                        "/media/card/infra/" 
;;                      remote-path))
;;          (timestamp (format-time-string "%H:%M:%S"))
;;          (buffer-name (format "*SCP-to-RUMI-%s-%s*" system-number timestamp)))
    
;;     (if (not (file-exists-p password-file))
;;         (error "Password file %s not found" password-file)
;;       (when (yes-or-no-p (format "SCP %d file(s) to %s:%s? " 
;;                                 (length files) host dest-path))
;;         (let ((file-list (mapconcat 'shell-quote-argument files " "))
;;               (full-command (format "sshpass -f %s scp %s %s root@%s:%s"
;;                                   password-file
;;                                   ssh-opts
;;                                   file-list
;;                                   host
;;                                   dest-path)))
;;           (message "Copying %d file(s) to %s:%s..." (length files) host dest-path)
;;           (async-shell-command full-command buffer-name))))))


(defun dired-scp-to-rumi (system-number &optional remote-path)
  "SCP marked files or file at point to a RUMI system.
SYSTEM-NUMBER is the system identifier (e.g., 1, 2, 3, etc.).
REMOTE-PATH is optional destination path (defaults to /media/card/infra/)."
  (interactive "sEnter RUMI system number: \nsRemote path (default: /media/card/infra/): ")
  (let* ((files (or (dired-get-marked-files) 
                   (list (dired-get-filename))))
         (host (format "san-r5v-0000%s" system-number))
         (password-file (expand-file-name "~/.rumi_pw"))
         (ssh-opts "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa -o PubkeyAcceptedKeyTypes=ssh-rsa")
         (dest-path (if (string-empty-p remote-path) 
                       "/media/card/infra/" 
                     remote-path))
         (timestamp (format-time-string "%H:%M:%S"))
         (buffer-name (format "*SCP-to-RUMI-%s-%s*" system-number timestamp))
         (file-list (mapconcat 'shell-quote-argument files " "))
         (full-command (format "sshpass -f %s scp %s %s root@%s:%s"
                              password-file
                              ssh-opts
                              file-list
                              host
                              dest-path)))
    
    (if (not (file-exists-p password-file))
        (error "Password file %s not found" password-file)
      (when (yes-or-no-p (format "SCP %d file(s) to %s:%s? " 
                                (length files) host dest-path))
        (message "Copying %d file(s) to %s:%s..." (length files) host dest-path)
        (async-shell-command full-command buffer-name)))))

;; Bind it to a key in dired mode
;; (eval-after-load 'dired
;;   '(define-key dired-mode-map (kbd "C-c s") 'dired-scp-to-rumi))
