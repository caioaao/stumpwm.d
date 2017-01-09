(in-package :stumpwm)

(load-module "hostname")
(load-module "mem")

;; Color caching

(setf *default-colors* *colors*)

(setf *colors*
      (append *default-colors*
              '("#009696")))

(update-color-map (current-screen))

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
            '(:eval (formatted-datetime *date-modeline-string*))
            " "
            '(:eval (formatted-datetime *time-modeline-string*))))

;; Turn on the modeline
(if (not (head-mode-line (current-head)))
    (toggle-mode-line (current-screen) (current-head)))
