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

(defmacro deficommand (name key-bindings)
  (let ((exit-command (format nil "icommand-exit-interactive-mode ~s" name))
        (m-name (gensym "m")))
    `(let ((,m-name (make-sparse-keymap)))
       ,@(loop for keyb in key-bindings
            collect `(define-key ,m-name ,@keyb))
       (define-key ,m-name (kbd "RET") ,exit-command)
       (define-key ,m-name (kbd "C-g") ,exit-command)
       (define-key ,m-name (kbd "ESC") ,exit-command)
       (defcommand ,name () ()
         (icommand-enter-interactive-mode ,m-name ,(symbol-name name))))))

