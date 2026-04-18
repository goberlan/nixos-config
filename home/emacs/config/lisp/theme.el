
(use-package circadian
  :config
  ;; needed to use :sunrise and :sunset
  (setq calendar-latitude 32.715736)
  (setq calendar-longitude -117.161087)
  (setq circadian-themes '((:sunrise . modus-operandi-tinted)
                           (:sunset  . wombat)))
  (circadian-setup))

(provide 'theme)
