#!/bin/bash
# link the virtual sync to your headphones should run when detected by UDEV
#
#

# wpctl status --name | grep 'alsa.output' | grep -Eo '\. \S*' | cut -c3-


desktop_group=$(pw-dump | jq '.[] | select( .type | contains("PipeWire:Interface:Node") ) | select( .info.props["node.group"] == "Desktop" )' | jq -s)


desktop_output=$(echo $desktop_group | jq '.[] | select( .info.props["custom.output.out"] )')
desktop_output_id=$(echo $desktop_output | jq -r '.id')

link=$(pw-dump | jq '.[] | select( .type | contains("PipeWire:Interface:Node") ) | select( .info.props["node.group"] == "Desktop" )' | jq -s)


echo $desktop_output_id

# PipeWire:Interface:Node => Mics Output (in and out), Desktop output (in and out), Device Node ()
# PipeWire:Interface:Port => LF and RH
# PipeWire:Interface:Device => Physical Decive
#
# PipeWire:Interface:Link => Data Structure


# wait a second for the drivers to load
# sleep 1s
#
# # link the headphones to your virtual sink
# sudo -u user1 env XDG_RUNTIME_DIR=/run/user/1000 pw-link "Desktop:monitor_FL" alsa_output.usb-Kingston_HyperX_Cloud_Flight_S_000000000001-00.analog-stereo:playback_FL
# sudo -u user1 env XDG_RUNTIME_DIR=/run/user/1000 pw-link "Desktop:monitor_FR" alsa_output.usb-Kingston_HyperX_Cloud_Flight_S_000000000001-00.analog-stereo:playback_FR
#
# # finish and return the code for success
# exit 1



# List device to up the sound level
# WIP: .[] | select( .type | contains("PipeWire:Interface:Device") ) | select ( .info.props["media.class"] | contains("Audio/Device") ) #| select( .info.props["device.disabled"]  ) #| .info.props
#
