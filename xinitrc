xset +fp /usr/share/fonts/local
xset fp rehash
# allow chroot environments to connect
xhost +local:

setxkbmap -option ctrl:nocaps
xmodmap ~/.Xmodmaprc
xrdb -merge ~/.Xresources

# urxvtd -q -f -o

redshift &
#nvidia-settings --load-config-only
# compton &
xscreensaver &
owncloud &
# mpd &
export DISPLAY=:0.0
xrandr --output HDMI-0 --off
xrandr --output HDMI-0 --auto --right-of DP-1
ibus-daemon --xim -d

exec awesome
