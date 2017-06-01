(in-package :stumpwm)

;; Programs
(define-key *root-map* (kbd "M-m") "spotify")
(define-key *root-map* (kbd "b") "exec chromium")
(define-key *root-map* (kbd "C-s") "colon1 exec xterm -e ssh ")
(define-key *root-map* (kbd "C-l") "exec i3lock -c 000000")
(define-key *root-map* (kbd "c") "exec urxvt")
(define-key *root-map* (kbd "C-c") "exec urxvt")

;; Swank bindings
(define-key *root-map* (kbd "M-s-s") "swank-start")
(define-key *root-map* (kbd "M-s-k") "swank-stop")

;; Window movement
(defvar vi-left "h")
(defvar vi-down "j")
(defvar vi-up "k")
(defvar vi-right "l")

(define-interactive-keymap imove-focus nil
    ((kbd vi-left) "move-focus left")
    ((kbd vi-up) "move-focus up")
    ((kbd vi-down) "move-focus down")
    ((kbd vi-right) "move-focus right"))

(define-key *root-map* (kbd "o") "imove-focus")

(define-key *root-map* (kbd vi-left) "move-focus left")
(define-key *root-map* (kbd vi-up) "move-focus up")
(define-key *root-map* (kbd vi-down) "move-focus down")
(define-key *root-map* (kbd vi-right) "move-focus right")

(define-key *root-map* (kbd (concatenate 'string "M-" vi-left)) "move-window left")
(define-key *root-map* (kbd (concatenate 'string "M-" vi-up)) "move-window up")
(define-key *root-map* (kbd (concatenate 'string "M-" vi-down)) "move-window down")
(define-key *root-map* (kbd (concatenate 'string "M-" vi-right)) "move-window right")

(define-key *root-map* (kbd "M-1") "only")

(define-key *root-map* (kbd "s-s") "hsplit-equally")
(define-key *root-map* (kbd "M-S") "vsplit-equally")

;; Load dev layout
(define-key *root-map* (kbd "M-d") "restore-from-file ~/.stumpwm.d/dumps/dev.lisp")

;; Connection menu
(define-key *root-map* (kbd "M-c") "exec netctl list | cut -b 3- | dmenu | ifne xargs sudo -A netctl switch-to")

;;; Media keys

;; Volume keys
(define-key *top-map* (kbd "XF86AudioLowerVolume") "amixer-Master-1-")
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "amixer-Master-1+")
(define-key *top-map* (kbd "XF86AudioMute") "amixer-Master-toggle")

;; Spotify control
(define-key *top-map* (kbd "XF86AudioPlay") "exec dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause")
(define-key *top-map* (kbd "XF86AudioPrev") "exec dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
(define-key *top-map* (kbd "XF86AudioNext") "exec dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")

;; Brightess
(define-key *top-map* (kbd "XF86MonBrightnessUp") "exec xbacklight -inc 8")
(define-key *top-map* (kbd "XF86MonBrightnessDown") "exec xbacklight -dec 8")

;; screenshots
(define-key *top-map* (kbd "Print") "exec escrotum ~/my/pics/screen-%Y-%m-%d-%H:%M:%S.png")
(define-key *top-map* (kbd "s-Print") "exec escrotum -s ~/my/pics/screen-%Y-%m-%d-%H:%M:%S.png")
