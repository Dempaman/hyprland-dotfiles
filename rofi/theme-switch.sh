#!/bin/bash
# Theme loader script for Rofi integration

THEME_DIR="$HOME/.config/rofi/themes"
THEME_CONFIG="$HOME/.config/rofi/config.rasi"
SYSTEM_THEME_DIR="/usr/share/rofi/themes"

# Create themes directory if it doesn't exist
mkdir -p "$THEME_DIR"

# Check if script was called with an argument (theme to apply)
if [ -n "$1" ]; then
    # Apply the selected theme
    if [ -f "$THEME_DIR/$1" ]; then
        echo "@theme \"$THEME_DIR/$1\"" > "$THEME_CONFIG"
        exit 0
    elif [ -f "$SYSTEM_THEME_DIR/$1" ]; then
        echo "@theme \"$SYSTEM_THEME_DIR/$1\"" > "$THEME_CONFIG"
        exit 0
    else
        echo "Theme not found: $1"
        exit 1
    fi
fi

# If no argument was provided, list all available themes
themes_list=""

# Get user themes
if [ -d "$THEME_DIR" ]; then
    for theme in "$THEME_DIR"/*.rasi; do
        if [ -f "$theme" ]; then
            theme_name=$(basename "$theme")
            themes_list+="$theme_name\n"
        fi
    done
fi

# Get system themes
if [ -d "$SYSTEM_THEME_DIR" ]; then
    for theme in "$SYSTEM_THEME_DIR"/*.rasi; do
        if [ -f "$theme" ]; then
            theme_name=$(basename "$theme")
            themes_list+="$theme_name\n"
        fi
    done
fi

# Remove trailing newline and output the list
echo -e "$themes_list" | sort | uniq