#!/usr/bin/env bash
# https://specifications.freedesktop.org/basedir-spec/latest/index.html
# xdg stands for "X Desktop Group" which is a set of standards

XDG_DATA_HOME_DEFAULT="$HOME/.local/share"
XDG_CONFIG_HOME_DEFAULT="$HOME/.config"
XDG_STATE_HOME_DEFAULT="$HOME/.local/state"
XDG_CACHE_HOME_DEFAULT="$HOME/.cache"

# Data Files (User-specific data files)
export XDG_DATA_HOME="${XDG_DATA_HOME:-$XDG_DATA_HOME_DEFAULT}"
# Config Files (User-specific configuration files)
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$XDG_CONFIG_HOME_DEFAULT}"
# State Files (Persisting data between app restarts, but not important or portable enough to be stored in the data directory, ex: layout, logs, etc.)
export XDG_STATE_HOME="${XDG_STATE_HOME:-$XDG_STATE_HOME_DEFAULT}"
# Cache Files (Non-essential files that can be removed at any time)
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$XDG_CACHE_HOME_DEFAULT}"

# Check if the XDG directories exist, if not, create them
for dir in "$XDG_DATA_HOME" "$XDG_CONFIG_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"; do
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
  fi
done