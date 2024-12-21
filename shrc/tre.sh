#!/usr/bin/env bash
tre() {
    command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null;
}