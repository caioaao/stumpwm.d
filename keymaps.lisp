(in-package :stumpwm)

;; Programs
(define-key *root-map* (kbd "M-m") "spotify")

;; Browser
(define-key *root-map* (kbd "b") "exec firefox")
;; Ssh somewhere
(define-key *root-map* (kbd "C-s") "colon1 exec xterm -e ssh ")
;; Lock screen
(define-key *root-map* (kbd "C-l") "exec i3lock -c 000000")

;; swank bindings
(define-key *root-map* (kbd "M-s-s") "swank-start")
(define-key *root-map* (kbd "M-s-k") "swank-stop")

;; Window movement
(defconstant vi-left "h")
(defconstant vi-down "j")
(defconstant vi-up "k")
(defconstant vi-right "l")

(define-key *root-map* (kbd vi-left) "move-focus left")
(define-key *root-map* (kbd vi-up) "move-focus up")
(define-key *root-map* (kbd vi-down) "move-focus down")
(define-key *root-map* (kbd vi-right) "move-focus right")

(define-key *root-map* (kbd (concatenate 'string "M-" vi-left)) "move-window left")
(define-key *root-map* (kbd (concatenate 'string "M-" vi-up)) "move-window up")
(define-key *root-map* (kbd (concatenate 'string "M-" vi-down)) "move-window down")
(define-key *root-map* (kbd (concatenate 'string "M-" vi-right)) "move-window right")

;; dev layout
(define-key *root-map* (kbd "M-d") "restore-from-file ~/.stumpwm.d/dumps/dev.lisp")


;; media
