(in-package :stumpwm)

;; First group
(defvar *startup-groups* '("devel" "www" "chat" "music"))

(defun setup-startup-groups ()
  (labels ((mk-command (cmd x) (concatenate 'string cmd " " x))
           (grename-command (x) (mk-command "grename" x))
           (gnewbg-command (x) (mk-command "gnewbg" x)))
    (let ((to-be-run (cons (grename-command (car *startup-groups*))
                           (mapcar #'gnewbg-command (cdr *startup-groups*)))))
      (apply #'run-commands to-be-run))))

(setup-startup-groups)
