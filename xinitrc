xset +fp /usr/share/fonts/local
xset fp rehash

setxkbmap -option ctrl:nocaps
xrdb -merge ~/.Xresources
#xcape -e 'Control_L=Escape'

urxvtd -q -f -o

redshift &
#nvidia-settings --load-config-only
compton &

exec awesome
