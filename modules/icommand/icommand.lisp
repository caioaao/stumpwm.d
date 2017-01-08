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

(defmacro deficommand (name key-bindings &key pre-start-fn)
  (let* ((command (if (listp name) (car name) name))
         (exit-command (format nil "icommand-exit-interactive-mode ~s" command))
         (m-name (gensym "m")))
    `(let ((,m-name (make-sparse-keymap)))
       ,@(loop for keyb in key-bindings
            collect `(define-key ,m-name ,@keyb))
       (define-key ,m-name (kbd "RET") ,exit-command)
       (define-key ,m-name (kbd "C-g") ,exit-command)
       (define-key ,m-name (kbd "ESC") ,exit-command)
       (defcommand ,name () ()
         ,(let ((start-code `(icommand-enter-interactive-mode ,m-name ,(symbol-name command))))
            (if pre-start-fn
                `(when (funcall ,pre-start-fn)
                   ,start-code)
                start-code))))))
