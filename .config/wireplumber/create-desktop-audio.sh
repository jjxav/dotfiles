#!/bin/bash

name="Desktop"
count=$(wpctl status | grep -E '\. Desktop' | wc -l)

echo $count

if [ $count == 1 ]; then
	exit 0;
fi

setting="
{
	factory.name=support.null-audio-sink
	node.name=""$name""
	node.description=""Desktop""
	media.class=Audio/Duplex
	object.linger=true
	audio.position=[FL FR]
}"

# Create a new sink called Simultaneous Output
pw-cli create-node adapter $setting

# Switch the default output to the new virtual sink
id=$(wpctl status | grep '. Desktop' | grep -E '[0-9]*' -o | head -n 1)
wpctl set-default $id
