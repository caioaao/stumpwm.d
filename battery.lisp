(in-package :stumpwm)

(add-screen-mode-line-formatter #\b 'fmt-bat-charge)

(defvar *bat-data* nil)

(defvar *bat-refresh-time* 15 "time in seconds between each refresh")

(defvar *bat-last-update* 0)

(defvar *battery-path* "/sys/class/power_supply/BAT0/")

(defun read-battery-file (fname)
  (with-open-file (file (concatenate 'string *battery-path* fname))
    (read-line file nil 'eof)))

(defun read-battery-data ()
  (list (cons 'status (read-battery-file "status"))
        (cons 'remain (parse-integer (read-battery-file "capacity")))))

(defun current-battery-data ()
  (let ((now (/ (get-internal-real-time) internal-time-units-per-second)))
    (when (or (= 0 *bat-last-update*)
            (>= (- now *bat-last-update*) *bat-refresh-time*))
        (setf *bat-last-update* now)
        (setf *bat-data* (read-battery-data)))
    *bat-data*))

(defun fmt-bat-charge (ml)
  (declare (ignore ml))
  (let ((battery-data (current-battery-data)))
    (format nil "BAT: ^[~A~D%^] (~A)"
            (bar-zone-color (cdr (assoc 'remain battery-data)) 50 30 10 t)
            (cdr (assoc 'remain battery-data))
            (cdr (assoc 'status battery-data)))))
