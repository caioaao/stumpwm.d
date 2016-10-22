(in-package :stumpwm)

;; quicklisp init
(load "~/.local/opt/quicklisp/setup.lisp")
(ql:quickload "swank")

(require :swank)
(swank-loader:init)

(defun start-swank ()
  (swank:create-server :port 4004
                       :style swank:*communication-style*
                       :dont-close t))

(defun stop-swank ()
  (swank:stop-server 4004))

(defcommand swank-start () () (start-swank))
(defcommand swank-stop  () () (stop-swank))
