(in-package :stumpwm)

(load-module "amixer")

(defcommand spotify () ()
  "run spotify"
  (run-or-raise "spotify" '(:class "Spotify")))
