#!/bin/sh
# Show tiramisu notifications in slstatus.

# How many seconds notification is displayed:
display_duration=3.0

# Maximum number of characters:
char_limit=41

# Notification sound path
sound=/usr/share/sounds/notification.wav

# Stop old tiramisu processes if any:
kill -9 $(pgrep -x tiramisu)

# Start a new tiramisu process:
tiramisu -o '#summary #body' |
    while read -r line; do
        
        # Cut notification by character limit:
        if [ "${#line}" -gt "$char_limit" ]; then
            line="$(echo "$line" | cut -c1-$((char_limit-1)))… "
        fi

        # Display notification for the duration time:
		kill -STOP $(pgrep -x slstatus)
		xsetroot -name " $line "
		aplay $sound
		sleep "$display_duration"
		kill -CONT $(pgrep -x slstatus)
    done
