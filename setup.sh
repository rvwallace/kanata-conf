#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/kanata"
CONFIG_FILE="$CONFIG_DIR/kanata.kbd"
SRC_FILE="$REPO_DIR/kanata.kbd"

# Kanata v1.12.0 (Homebrew stable) requires DriverKit v6.2.0 (Protocol 5)
DRIVER_PKG_URL="https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/download/v6.2.0/Karabiner-DriverKit-VirtualHIDDevice-6.2.0.pkg"
PKG_TMP="/tmp/Karabiner-DriverKit-VirtualHIDDevice-6.2.0.pkg"
DAEMON_PLIST="/Library/LaunchDaemons/org.pqrs.karabiner.driverkit-virtualhiddevice.plist"
LOCAL_PLIST="$REPO_DIR/org.pqrs.karabiner.driverkit-virtualhiddevice.plist"

echo "========================================================"
echo "          Kanata Setup for macOS / NuPhy & Laptop       "
echo "========================================================"
echo ""

# 1. Check Homebrew & Kanata
if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Error: Homebrew is not installed."
    exit 1
fi

if ! command -v kanata >/dev/null 2>&1; then
    echo "📦 Installing Kanata via Homebrew..."
    brew install kanata
else
    echo "✅ Kanata is installed: $(kanata --version)"
fi

# 2. Download and install matching DriverKit v6.2.0 package
echo ""
echo "🔍 Downloading matching Karabiner DriverKit v6.2.0 for Kanata..."
curl -sL "$DRIVER_PKG_URL" -o "$PKG_TMP"

echo "📦 Installing DriverKit v6.2.0 package (sudo required)..."
sudo installer -pkg "$PKG_TMP" -target /

# 3. Clean stale socket files & reset ownership
echo ""
echo "🧹 Purging stale socket files & resetting root:wheel ownership..."
sudo rm -rf "/Library/Application Support/org.pqrs/tmp" || true
sudo mkdir -p "/Library/Application Support/org.pqrs"
sudo chown -R root:wheel "/Library/Application Support/org.pqrs"
sudo chmod 755 "/Library/Application Support/org.pqrs"
sudo killall -9 Karabiner-VirtualHIDDevice-Daemon 2>/dev/null || true

# 4. Force activate DriverKit v6.2.0
echo ""
echo "🚀 Activating Virtual HID Manager..."
if [ -f "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" ]; then
    sudo "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" forceActivate || true
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
echo "✅ LaunchDaemon registered."

# 6. Symlink Config
echo ""
echo "🔗 Setting up configuration symlink..."
mkdir -p "$CONFIG_DIR"
ln -sf "$SRC_FILE" "$CONFIG_FILE"
echo "   $SRC_FILE -> $CONFIG_FILE"

# 7. Restart Kanata background service
echo ""
echo "🔄 Restarting Kanata service..."
sudo brew services restart kanata

# 8. Validate Syntax
echo ""
echo "🧪 Validating Kanata configuration syntax..."
kanata --check -c "$CONFIG_FILE"
echo "✅ Configuration syntax is valid!"

echo ""
echo "========================================================"
echo "                  SETUP COMPLETE                        "
echo "========================================================"
echo "DriverKit v6.2.0 installed and Kanata restarted!"
echo "========================================================"
