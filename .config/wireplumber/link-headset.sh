#!/bin/bash
# link the virtual sync to your headphones should run when detected by UDEV
#
#

wpctl status --name | grep 'alsa.output' | grep -Eo '\. \S*' | cut -c3-


# wait a second for the drivers to load
# sleep 1s
#
# # link the headphones to your virtual sink
# sudo -u user1 env XDG_RUNTIME_DIR=/run/user/1000 pw-link "Desktop:monitor_FL" alsa_output.usb-Kingston_HyperX_Cloud_Flight_S_000000000001-00.analog-stereo:playback_FL
# sudo -u user1 env XDG_RUNTIME_DIR=/run/user/1000 pw-link "Desktop:monitor_FR" alsa_output.usb-Kingston_HyperX_Cloud_Flight_S_000000000001-00.analog-stereo:playback_FR
#
# # finish and return the code for success
# exit 0
