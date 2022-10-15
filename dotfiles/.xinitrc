xrandr -s 1920x1080
xautolock -time 10 -locker slock &
feh --bg-scale $HOME/.wallpapers/wallpaper.jpg
xcompmgr &
exec slstatus &
exec dwm
