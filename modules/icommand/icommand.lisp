;;;; icommand.lisp

(in-package #:icommand)
;;; Little macro to define interactive commands.

(export '(icommand-enter-interactive-mode
          deficommand))

(defcommand icommand-exit-interactive-mode
    (name) ((:string "Interactive mode name (will show on message)"))
  "Exits imove-focus mode"
  (message "~s finished" name)
  (stumpwm::pop-top-map))

(defun icommand-enter-interactive-mode
    (kmap name)
  (message (format nil "~s started" name))
  (stumpwm::push-top-map kmap))

(defmacro deficommand (icmd-name key-bindings)
  `(let ((m (make-sparse-keymap)))
     ,@(loop for keyb in key-bindings
          collect `(define-key m ,@keyb))
     (define-key m (kbd "RET") ,(format nil "icommand-exit-interactive-mode ~s" icmd-name))
     (define-key m (kbd "C-g") ,(format nil "icommand-exit-interactive-mode ~s" icmd-name))
     (define-key m (kbd "ESC") ,(format nil "icommand-exit-interactive-mode ~s" icmd-name))
     (defcommand ,icmd-name () ()
       (icommand-enter-interactive-mode m ,(symbol-name icmd-name)))))

