(in-package :stumpwm)

(load-module "amixer")

(defcommand spotify () ()
  "run spotify"
  (run-or-raise "spotify" '(:class "Spotify")))


;; mpd client
(load-module "mpd")
(mpd:mpd-connect)
