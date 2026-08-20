#!/usr/bin/env bash
set -e

INSTALL_DIR="${HOME}/.local/bin"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="${SCRIPT_DIR}/cl-sw"

echo "📦 Installing Claude Code Switcher (cl-sw)..."

# Ensure install dir exists
mkdir -p "${INSTALL_DIR}"

# Copy main binary
cp -f "${SOURCE_FILE}" "${INSTALL_DIR}/cl-sw"
chmod +x "${INSTALL_DIR}/cl-sw"

# Create symlinks
for alias_name in claude-config claude-switch cc-switch cconf; do
    ln -sf "${INSTALL_DIR}/cl-sw" "${INSTALL_DIR}/${alias_name}"
done

# Check PATH
case ":$PATH:" in
    *":${INSTALL_DIR}:"*)
        ;;
    *)
        echo "⚠️  ${INSTALL_DIR} is not in your PATH."
        echo "👉 Add this line to your ~/.zshrc or ~/.bashrc:"
        echo "   export PATH=\"\${HOME}/.local/bin:\$PATH\""
        ;;
esac

echo "✅ Installation completed successfully!"
echo ""
echo "🚀 You can now run:"
echo "   cl-sw                 (interactive menu)"
echo "   cl-sw list            (list profiles)"
echo "   cl-sw <profile_name>  (switch to specific profile)"
