#!/bin/bash

VOLONOFF="$(amixer sget Master | grep Left: | sed 's/[][]//g' | awk '{print $7}')"
VOL="$(amixer sget Master | awk -F'[][]' 'END{print $2}')"

VOLICON=""
MUTEICON="Muted"


if [ "$VOLONOFF" = "on" ]; then
		echo "$VOLICON $VOL"
	else
		echo "$MUTEICON"
fi
