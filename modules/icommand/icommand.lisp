;;;; icommand.lisp

(in-package #:icommand)

;;; Little macro to define interactive commands.

(export '(icommand-enter-interactive-mode
          icommand-exit-interactive-mode
          deficommand))

(defun icommand-enter-interactive-mode
    (kmap name)
  (message (format nil "~s started" name))
  (stumpwm::push-top-map kmap))

(defun icommand-exit-interactive-mode (name)
  "Exits imove-focus mode"
  (message "~s finished" name)
  (stumpwm::pop-top-map))

(defmacro deficommand (name key-bindings &key pre-start-fn cleanup-fn)
  (let* ((command (if (listp name) (car name) name))
         (exit-command (concatenate 'string "exit-" (symbol-name command)))
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
                start-code)))
       (defcommand ,(intern exit-command) () ()
         (when ,cleanup-fn (funcall ,cleanup-fn))
         (icommand-exit-interactive-mode ,(symbol-name command))))))
