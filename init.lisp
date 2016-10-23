(in-package :stumpwm)

(defvar *stumpwm-config-dir* "~/.stumpwm.d/"
  "StumpWM configuration directory.")

(defun rel-path (suffix)
  "Path relative to `*stumpwm-config-dir*`"
  (concat *stumpwm-config-dir* suffix))

(defvar *data-dir* (rel-path "dump/"))

(load (rel-path "theme.lisp"))

(load (rel-path "media.lisp"))

;; swank stuff
(load (rel-path "swank.lisp"))

;; keymaps
(load (rel-path "keymaps.lisp"))

;; change the prefix key to something else
(set-prefix-key (kbd "C-q"))

;; Set focus to follow mouse
(setf *mouse-focus-policy* :sloppy)


;; prompt the user for an interactive command. The first arg is an
;; optional initial contents.
(defcommand colon1 (&optional (initial "")) (:rest)
  (let ((cmd (read-one-line (current-screen) ": " :initial-input initial)))
    (when cmd
      (eval-command cmd t))))

;; Message window font
(set-font "-xos4-terminus-medium-r-normal--14-140-72-72-c-80-iso8859-15")

;;; Define window placement policy...

;; Clear rules
(clear-window-placement-rules)

(define-frame-preference "Music"
    (0 T T :create "music-dump" :class "Spotify")) ;; this is broken :(

(define-frame-preference "Steam"
    (0 T T :create "steam-dump" :class "Steam"))

(define-frame-preference "csgo"
    (0 T T :create "gaming-dump" :class "csgo_linux64"))
