#!/usr/bin/env bash

[[ -z $1 ]] && return 1
[[ -z $2 ]] && return 1

name=$2.conf

theme_monitor_1_path=~/dotfiles/.config/hypr/theme/backgrounds/monitor_1-$name
theme_monitor_2_path=~/dotfiles/.config/hypr/theme/backgrounds/monitor_2-$name
theme_monitor_3_path=~/dotfiles/.config/hypr/theme/backgrounds/monitor_3-$name


raw_colors=$(gowall extract $1 -c 5 2> /dev/null | awk -F ':::' '{ print $1 }' | xargs | tr "[:space:]" ';' | tr -d '#')
raw_colors=${raw_colors::-1}

IFS=";" read -r -a colors <<< "$raw_colors"

mkdir -p $(dirname $theme_monitor_1_path)
mkdir -p $(dirname $theme_monitor_2_path)
mkdir -p $(dirname $theme_monitor_3_path)

cat <<- THEME > $theme_monitor_1_path
	\$monitor1_color1 = rgb(${colors[0]})
	\$monitor1_color2 = rgb(${colors[1]})
	\$monitor1_color3 = rgb(${colors[2]})
	\$monitor1_color4 = rgb(${colors[3]})
	\$monitor1_color5 = rgb(${colors[4]})
THEME

cat <<- THEME > $theme_monitor_2_path
	\$monitor2_color1 = rgb(${colors[0]})
	\$monitor2_color2 = rgb(${colors[1]})
	\$monitor2_color3 = rgb(${colors[2]})
	\$monitor2_color4 = rgb(${colors[3]})
	\$monitor2_color5 = rgb(${colors[4]})
THEME

cat <<- THEME > $theme_monitor_3_path
	\$monitor3_color1 = rgb(${colors[0]})
	\$monitor3_color2 = rgb(${colors[1]})
	\$monitor3_color3 = rgb(${colors[2]})
	\$monitor3_color4 = rgb(${colors[3]})
	\$monitor3_color5 = rgb(${colors[4]})
THEME
