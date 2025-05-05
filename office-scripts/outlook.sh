#!/bin/bash
google-chrome --app=https://outlook.office.com &
sleep 0.7
hyprctl dispatch togglefloating address:$(hyprctl activewindow -j | jq -r .address)
