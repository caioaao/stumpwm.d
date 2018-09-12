(in-package :stumpwm)

(load-module "hostname")
(load-module "mem")
(load-module "ttf-fonts")

;; Color caching

(setf *default-colors* *colors*)

(setf *colors*
      (append *default-colors*
              '("#009696")))

(update-color-map (current-screen))

;; Font config
(xft:cache-fonts)
(set-font (make-instance 'xft:font :family "Anonymous Pro" :subfamily "Regular" :size 13))

;;; Window Appearance
(setf *normal-border-width* 0
      *maxsize-border-width* 0
      *transient-border-width* 1
      *window-border-style* :thick) ; :thick :thin :tight :none

;;; Modeline Appearance
(setf *mode-line-background-color* "#000809"
      *mode-line-foreground-color* "DeepSkyBlue"
      *mode-line-timeout* 1
      *mode-line-position* :top
      *window-format* "%m%n%s%20t"
      *group-format* " %t ")

(setf *date-modeline-string* "^8 %F %a^n")
(setf *time-modeline-string* "^7^B%R^b^n")

(defun formatted-datetime (s)
  (string-trim '(#\Newline)
               (run-shell-command
                (format nil "date +\"~A\"" s) t)))

(defun mode-line-list (l)
  (if (cdr l)
      (append (list "[" (car l) "] | ") (mode-line-list (cdr l)))
      (list "[" (car l) "]")))

(setf *screen-mode-line-format*
      (list "^B^3 %g ^n^b %W "
            "^>"
            "^8 %M^n"
            "^8 %b^n"
            '(:eval (formatted-datetime *date-modeline-string*))
            " "
            '(:eval (formatted-datetime *time-modeline-string*))))

;; Turn on the modeline
(defun turn-mode-line-on (head screen)
  (if (not (head-mode-line head))
      (toggle-mode-line screen head)))

(defun turn-mode-lines-on-for-all-heads ()
  (let ((screen (current-screen)))
    (loop for head in (screen-heads screen) do
         (turn-mode-line-on head screen))))

(turn-mode-lines-on-for-all-heads)

(defcommand refresh-mode-lines () ()
  (progn
    (message "Refreshing mode lines")
    (turn-mode-lines-on-for-all-heads)))

;; TODO this is currently broken
;; (add-hook *new-head-hook* #'turn-mode-line-on)
