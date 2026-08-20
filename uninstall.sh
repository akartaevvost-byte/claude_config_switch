#!/usr/bin/env bash
set -e

INSTALL_DIR="${HOME}/.local/bin"

echo "🗑️  Removing Claude Code Switcher..."

for cmd in cl-sw claude-config claude-switch cc-switch cconf; do
    if [ -f "${INSTALL_DIR}/${cmd}" ] || [ -L "${INSTALL_DIR}/${cmd}" ]; then
        rm -f "${INSTALL_DIR}/${cmd}"
        echo "   Removed ${INSTALL_DIR}/${cmd}"
    fi
done

echo "✅ Uninstalled successfully."
