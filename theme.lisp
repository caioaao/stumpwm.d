(in-package :stumpwm)

(load-module "hostname")
(load-module "net")
(load-module "cpu")
(load-module "mem")
(load-module "disk")



;;; Window Appearance
(setf *normal-border-width* 0
      *maxsize-border-width* 0
      *transient-border-width* 1
      *window-border-style* :thick) ; :thick :thin :tight :none

;;; Modeline Appearance
(setf *mode-line-background-color* "#583d5e"
      *mode-line-foreground-color* "White"
      *mode-line-border-color* "White"
      *mode-line-timeout* 1
      *mode-line-position* :top
      *window-format* "^B^8*%n%s%m%30t :: ^7*"
      *group-format* "%t")

(defun mode-line-list (l)
  (if (cdr l)
      (append (list "[" (car l) "] | ") (mode-line-list (cdr l)))
      (list "[" (car l) "]")))

(setf *screen-mode-line-format*
      (mode-line-list (list "%g"
                            "^[^B^7*%h^] @ %n"
                            "%C %t"
                            "%M"
                            "%D"
                            '(:eval (string-trim '(#\Newline)
                                     (run-shell-command "date '+%R, %F %a'" t))))))

;; Turn on the modeline
(if (not (head-mode-line (current-head)))
    (toggle-mode-line (current-screen) (current-head)))
