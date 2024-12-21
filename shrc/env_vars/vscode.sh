#!/usr/bin/env bash
export VSCODE_CONFIG_PATH="/Users/gat/Library/Application Support/Code/User/setting.json"

if [ -z "$XDG_CONFIG_HOME" ]; then
    echo "XDG_CONFIG_HOME is not set, run xdg.sh before running this script" >&2
    exit 1
fi

export VSCODE_WORKSPACES_PATH="$XDG_CONFIG_HOME/vscode/workspaces"