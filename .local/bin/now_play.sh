#!/usr/bin/env bash

if ps -A | grep ncspot > /dev/null; then
    artist=`playerctl -p ncspot metadata artist`
    title=`playerctl -p ncspot metadata title`
    echo " ${artist} - ${title}"
fi
