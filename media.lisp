(in-package :stumpwm)

(defcommand spotify () ()
  "run spotify"
  (run-or-raise "spotify" '(:class "Spotify")))
