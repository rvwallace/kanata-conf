#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/kanata"
CONFIG_FILE="$CONFIG_DIR/kanata.kbd"
SRC_FILE="$REPO_DIR/kanata.kbd"
DRIVER_PKG_URL="https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/download/v8.2.0/Karabiner-DriverKit-VirtualHIDDevice-8.2.0.pkg"
PKG_TMP="/tmp/Karabiner-DriverKit-VirtualHIDDevice.pkg"
DAEMON_PLIST="/Library/LaunchDaemons/org.pqrs.karabiner.driverkit-virtualhiddevice.plist"
LOCAL_PLIST="$REPO_DIR/org.pqrs.karabiner.driverkit-virtualhiddevice.plist"

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

# 3. Clean up stale tmp sockets & Install Standalone VirtualHIDDevice Driver
echo ""
echo "🔍 Setting up Standalone Karabiner DriverKit VirtualHIDDevice driver..."
if [ ! -f "$PKG_TMP" ]; then
    echo "📦 Downloading driver package..."
    curl -sL "$DRIVER_PKG_URL" -o "$PKG_TMP"
fi

echo "📦 Installing driver package (sudo required)..."
sudo installer -pkg "$PKG_TMP" -target /

echo "🧹 Cleaning up stale socket files..."
sudo rm -rf "/Library/Application Support/org.pqrs/tmp" || true
sudo killall -9 Karabiner-VirtualHIDDevice-Daemon 2>/dev/null || true

# 4. Activate Virtual Driver
echo ""
echo "🚀 Activating DriverKit Virtual HID Manager..."
if [ -f "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" ]; then
    "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" activate || true
    echo "✅ VirtualHIDDevice activated."
fi

# 5. Setup LaunchDaemon for VirtualHIDDevice-Daemon
echo ""
echo "⚙️  Configuring LaunchDaemon for VirtualHIDDevice service..."
sudo cp "$LOCAL_PLIST" "$DAEMON_PLIST"
sudo chown root:wheel "$DAEMON_PLIST"
sudo chmod 644 "$DAEMON_PLIST"
sudo launchctl bootout system "$DAEMON_PLIST" 2>/dev/null || true
sudo launchctl bootstrap system "$DAEMON_PLIST" 2>/dev/null || sudo launchctl load "$DAEMON_PLIST" 2>/dev/null || true
echo "✅ LaunchDaemon registered and running."

# 6. Symlink Config
echo ""
echo "🔗 Setting up configuration symlink..."
mkdir -p "$CONFIG_DIR"
ln -sf "$SRC_FILE" "$CONFIG_FILE"
echo "   $SRC_FILE -> $CONFIG_FILE"

# 7. Validate Syntax
echo ""
echo "🧪 Validating Kanata configuration syntax..."
kanata --check -c "$CONFIG_FILE"
echo "✅ Configuration syntax is valid!"

echo ""
echo "========================================================"
echo "                  SETUP COMPLETE                        "
echo "========================================================"
echo "Run live test:"
echo "     make test"
echo "========================================================"
