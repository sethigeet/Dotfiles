#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define some helper functions
. "$CURRENT_DIR/helpers.sh"

# Set the theme
. "$CURRENT_DIR/theme.sh"

# Set the status bar
. "$CURRENT_DIR/status-bar.sh"

# Highlight the status bar when the prefix is pressed
. "$CURRENT_DIR/prefix-highlight.sh"

# Show the status of the internet connection
. "$CURRENT_DIR/online-status.sh"
