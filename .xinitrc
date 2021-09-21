#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
    #[ -x "$f" ] && . "$f"
  #done
  #unset f
#fi

export PATH="${PATH}:$HOME/.config/composer/vendor/bin"


xset -dpms &
xset s off &
#/usr/lib/notification-daemon-1.0/notification-daemon &
/usr/bin/dunst &
kbdd &
xsetroot -coursor_name Left_ptr
setxkbmap -layout us,ru,ua -option grp:lctrl_toggle,caps:ctrl_modifier,grp_led:scroll,terminate:ctrl_alt_bksp &
exec dbus-launch xmonad
#exec dbus-launch i3
