(in-package :stumpwm)

(load-module "icommand")


;; Programs
(define-key *root-map* (kbd "M-m") "spotify")
(define-key *root-map* (kbd "b") "exec firefox")
(define-key *root-map* (kbd "C-s") "colon1 exec xterm -e ssh ")
(define-key *root-map* (kbd "C-l") "exec i3lock -c 000000")

;; Swank bindings
(define-key *root-map* (kbd "M-s-s") "swank-start")
(define-key *root-map* (kbd "M-s-k") "swank-stop")

;; Window movement
(defvar vi-left "h")
(defvar vi-down "j")
(defvar vi-up "k")
(defvar vi-right "l")

(icommand:deficommand imove-focus
    (((kbd vi-left) "move-focus left")
     ((kbd vi-up) "move-focus up")
     ((kbd vi-down) "move-focus down")
     ((kbd vi-right) "move-focus right")))

(define-key *root-map* (kbd "o") "imove-focus")

(define-key *root-map* (kbd vi-left) "move-focus left")
(define-key *root-map* (kbd vi-up) "move-focus up")
(define-key *root-map* (kbd vi-down) "move-focus down")
(define-key *root-map* (kbd vi-right) "move-focus right")

(define-key *root-map* (kbd (concatenate 'string "M-" vi-left)) "move-window left")
(define-key *root-map* (kbd (concatenate 'string "M-" vi-up)) "move-window up")
(define-key *root-map* (kbd (concatenate 'string "M-" vi-down)) "move-window down")
(define-key *root-map* (kbd (concatenate 'string "M-" vi-right)) "move-window right")

;; Load dev layout
(define-key *root-map* (kbd "M-d") "restore-from-file ~/.stumpwm.d/dumps/dev.lisp")

;;; Media keys

;; Volume keys
(define-key *top-map* (kbd "XF86AudioLowerVolume") "amixer-Master-1-")
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "amixer-Master-1+")
(define-key *top-map* (kbd "XF86AudioMute") "amixer-Master-toggle")
