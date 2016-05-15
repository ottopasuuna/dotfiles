xset +fp /usr/share/fonts/local
xset fp rehash
# allow chroot environments to connect
xhost +local:

setxkbmap -option ctrl:nocaps
xrdb -merge ~/.Xresources

# urxvtd -q -f -o

redshift &
#nvidia-settings --load-config-only
# compton &
xscreensaver &
owncloud &
mpd &

exec awesome
