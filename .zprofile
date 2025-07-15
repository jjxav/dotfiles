
if uwsm check may-start 2>&1 > /dev/null ; then
    exec uwsm start hyprland-uwsm.desktop
fi

