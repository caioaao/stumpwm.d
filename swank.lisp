;; quicklisp init
(load "~/.local/opt/quicklisp/setup.lisp")
(ql:quickload "swank")

(require :swank)
(swank-loader:init)

(defvar server-port 4004)

(defun start-swank ()
  (swank:create-server :port server-port
                       :style swank:*communication-style*
                       :dont-close t)
  (message "Server created at port ~s" server-port))

(defun stop-swank ()
  (swank:stop-server server-port)
  (message "Stopped server at port ~s" server-port))

(defcommand swank-start () () (start-swank))
(defcommand swank-stop  () () (stop-swank))
