#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/kanata"
CONFIG_FILE="$CONFIG_DIR/kanata.kbd"
SRC_FILE="$REPO_DIR/kanata.kbd"
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
fi

KANATA_VERSION_STR=$(kanata --version 2>/dev/null || echo "kanata 1.12.0")
KANATA_VERSION=$(echo "$KANATA_VERSION_STR" | awk '{print $2}')
echo "✅ Kanata installed: version $KANATA_VERSION"

# 2. Determine matching DriverKit version based on Kanata version protocol
# Official Kanata Docs Reference: https://github.com/jtroo/kanata/blob/main/docs/setup-macos.md
# - Kanata >= 1.13.0 uses karabiner-driverkit v0.4.0 (Protocol 7) -> requires DriverKit v8.0.0 / v8.2.0+
# - Kanata <  1.13.0 uses karabiner-driverkit v0.3.x (Protocol 5) -> requires DriverKit v6.2.0
MAJOR=$(echo "$KANATA_VERSION" | cut -d. -f1)
MINOR=$(echo "$KANATA_VERSION" | cut -d. -f2)

if [ "$MAJOR" -gt 1 ] || { [ "$MAJOR" -eq 1 ] && [ "$MINOR" -ge 13 ]; }; then
    DRIVER_VER="8.2.0"
    PROTOCOL="7"
    DRIVER_PKG_URL="https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/download/v8.2.0/Karabiner-DriverKit-VirtualHIDDevice-8.2.0.pkg"
else
    DRIVER_VER="6.2.0"
    PROTOCOL="5"
    DRIVER_PKG_URL="https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/download/v6.2.0/Karabiner-DriverKit-VirtualHIDDevice-6.2.0.pkg"
fi

PKG_TMP="/tmp/Karabiner-DriverKit-VirtualHIDDevice-${DRIVER_VER}.pkg"
echo "🎯 Matching Karabiner DriverKit: v${DRIVER_VER} (Protocol ${PROTOCOL} for Kanata v${KANATA_VERSION})"

# 3. Download and install driver package
if [ ! -f "$PKG_TMP" ]; then
    echo "📦 Downloading Karabiner DriverKit v${DRIVER_VER}..."
    curl -sL "$DRIVER_PKG_URL" -o "$PKG_TMP"
fi

echo "📦 Installing DriverKit v${DRIVER_VER} (sudo required)..."
sudo installer -pkg "$PKG_TMP" -target /

# 4. Clean stale socket files & reset ownership
echo ""
echo "🧹 Resetting socket directory with root:wheel ownership..."
sudo rm -rf "/Library/Application Support/org.pqrs/tmp" || true
sudo mkdir -p "/Library/Application Support/org.pqrs"
sudo chown -R root:wheel "/Library/Application Support/org.pqrs"
sudo chmod 755 "/Library/Application Support/org.pqrs"
sudo killall -9 Karabiner-VirtualHIDDevice-Daemon 2>/dev/null || true

# 5. Activate DriverKit
echo ""
echo "🚀 Activating Virtual HID Manager..."
if [ -f "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" ]; then
    sudo "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" forceActivate 2>/dev/null || \
    sudo "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" activate || true
    echo "✅ VirtualHIDDevice activated."
fi

# 6. Setup LaunchDaemon for VirtualHIDDevice-Daemon
echo ""
echo "⚙️  Configuring LaunchDaemon for VirtualHIDDevice service..."
sudo cp "$LOCAL_PLIST" "$DAEMON_PLIST"
sudo chown root:wheel "$DAEMON_PLIST"
sudo chmod 644 "$DAEMON_PLIST"
sudo launchctl bootout system "$DAEMON_PLIST" 2>/dev/null || true
sudo launchctl bootstrap system "$DAEMON_PLIST" 2>/dev/null || sudo launchctl load "$DAEMON_PLIST" 2>/dev/null || true
echo "✅ LaunchDaemon registered."

# 7. Symlink Config
echo ""
echo "🔗 Setting up configuration symlink..."
mkdir -p "$CONFIG_DIR"
ln -sf "$SRC_FILE" "$CONFIG_FILE"
echo "   $SRC_FILE -> $CONFIG_FILE"

# 8. Restart Kanata background service
echo ""
echo "🔄 Restarting Kanata service..."
sudo brew services restart kanata

# 9. Validate Syntax
echo ""
echo "🧪 Validating Kanata configuration syntax..."
kanata --check -c "$CONFIG_FILE"
echo "✅ Configuration syntax is valid!"

echo ""
echo "========================================================"
echo "                  SETUP COMPLETE                        "
echo "========================================================"
echo "Kanata is running with DriverKit v${DRIVER_VER}."
echo "========================================================"
