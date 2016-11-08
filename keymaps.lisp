(in-package :stumpwm)

;; Programs
(define-key *root-map* (kbd "M-m") "spotify")
(define-key *root-map* (kbd "b") "exec firefox")
(define-key *root-map* (kbd "C-s") "colon1 exec xterm -e ssh ")
(define-key *root-map* (kbd "C-l") "exec i3lock -c 000000")

;; Swank bindings
(define-key *root-map* (kbd "M-s-s") "swank-start")
(define-key *root-map* (kbd "M-s-k") "swank-stop")

;; Window movement
(defvar *imove-focus-map* (make-sparse-keymap))

;; (defvar vi-left "h")
;; (defvar vi-down "j")
;; (defvar vi-up "k")
;; (defvar vi-right "l")

(defcommand exit-imove-focus () ()
  "Exits imove-focus mode"
  (message "Interactive focus mode finished")
  (pop-top-map))


(defun update-imove-focus-map ()
  (let ((m (or *imove-focus-map* (setf *imove-focus-map* (make-sparse-keymap)))))
    (define-key m (kbd vi-left) "move-focus left")
    (define-key m (kbd vi-up) "move-focus up")
    (define-key m (kbd vi-down) "move-focus down")
    (define-key m (kbd vi-right) "move-focus right")

    (define-key m (kbd "RET") "exit-imove-focus")
    (define-key m (kbd "C-g") "exit-imove-focus")
    (define-key m (kbd "ESC") "exit-imove-focus")
    m))

(update-imove-focus-map)

(defcommand imove-focus () ()
  "Start interactive move focus mode. A new keymap specific to moving focus is
  loaded. Hit @key{C-g}, @key{RET} or @key{ESC} to exit."
  (message "Interactive move focus")
  (push-top-map *imove-focus-map*))

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

;; mpd control
(load-module "mpd")
(define-key *top-map* (kbd "XF86AudioPlay") "mpd-toggle-pause")
(define-key *top-map* (kbd "XF86AudioPrev") "mpd-prev")
(define-key *top-map* (kbd "XF86AudioNext") "mpd-next")
(define-key mpd:*mpd-map* (kbd "p") "mpd-select-playlist")
(define-key *root-map* (kbd "C-m") mpd:*mpd-map*)
