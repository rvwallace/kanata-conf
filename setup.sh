#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/kanata"
CONFIG_FILE="$CONFIG_DIR/kanata.kbd"
SRC_FILE="$REPO_DIR/kanata.kbd"
DRIVER_PKG_URL="https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/download/v8.2.0/Karabiner-DriverKit-VirtualHIDDevice-8.2.0.pkg"
PKG_TMP="/tmp/Karabiner-DriverKit-VirtualHIDDevice.pkg"

echo "========================================================"
echo "          Kanata Setup for macOS / NuPhy & Laptop       "
echo "========================================================"
echo ""

# 1. Check Homebrew
if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Error: Homebrew is not installed."
    exit 1
fi

# 2. Install Kanata
if ! command -v kanata >/dev/null 2>&1; then
    echo "📦 Installing Kanata via Homebrew..."
    brew install kanata
else
    echo "✅ Kanata is installed: $(kanata --version)"
fi

# 3. Check / Install Standalone VirtualHIDDevice Driver
echo ""
echo "🔍 Checking Standalone Karabiner DriverKit VirtualHIDDevice driver..."
if [ ! -d "/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice" ] || [ ! -f "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" ]; then
    echo "📦 Downloading standalone VirtualHIDDevice driver..."
    curl -sL "$DRIVER_PKG_URL" -o "$PKG_TMP"
    echo "⚠️  Installing driver package (requires sudo password in terminal)..."
    sudo installer -pkg "$PKG_TMP" -target /
fi

# 4. Activate Virtual Driver
echo ""
echo "🚀 Activating DriverKit Virtual HID Manager..."
if [ -f "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" ]; then
    "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" activate || true
    echo "✅ VirtualHIDDevice activated."
fi

# 5. Symlink Config
echo ""
echo "🔗 Setting up configuration symlink..."
mkdir -p "$CONFIG_DIR"
ln -sf "$SRC_FILE" "$CONFIG_FILE"
echo "   $SRC_FILE -> $CONFIG_FILE"

# 6. Validate Syntax
echo ""
echo "🧪 Validating Kanata configuration syntax..."
kanata --check -c "$CONFIG_FILE"
echo "✅ Configuration syntax is valid!"

echo ""
echo "========================================================"
echo "                       NEXT STEPS                       "
echo "========================================================"
echo "1. If Karabiner-Elements was previously installed, uninstall it:"
echo "     brew uninstall --cask karabiner-elements"
echo ""
echo "2. Grant Permissions in macOS System Settings:"
echo "   • Privacy & Security -> Input Monitoring  -> Enable 'kanata'"
echo "   • Privacy & Security -> Accessibility     -> Enable 'kanata'"
echo ""
echo "3. Run live test:"
echo "     make test"
echo "========================================================"
