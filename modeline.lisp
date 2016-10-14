(in-package :stumpwm)

(setf *mode-line-background-color* "#583d5e"
      *mode-line-foreground-color* "White"
      *mode-line-border-color* "White"
      *mode-line-timeout* 1
      *mode-line-position* :top
      *window-format* "^B^8*%n%s%m%30t :: ^7*"
      *group-format* "%t")
(setf *screen-mode-line-format*
     (list '(" " (:eval (run-shell-command "date '+%R, %F %a'|tr -d [:cntrl:]" t)))))
