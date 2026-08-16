#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/kanata"
CONFIG_FILE="$CONFIG_DIR/kanata.kbd"
SRC_FILE="$REPO_DIR/kanata.kbd"

echo "========================================================"
echo "          Kanata Setup for macOS / NuPhy & Laptop       "
echo "========================================================"
echo ""

# 1. Check Homebrew
if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Error: Homebrew is not installed. Please install Homebrew first:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

# 2. Install Kanata
if ! command -v kanata >/dev/null 2>&1; then
    echo "📦 Installing Kanata via Homebrew..."
    brew install kanata
else
    echo "✅ Kanata is already installed: $(kanata --version)"
fi

# 3. Check / Install Karabiner Virtual Driver
echo ""
echo "🔍 Checking Karabiner DriverKit driver..."
if [ ! -d "/Library/Application Support/org.pqrs" ] && [ ! -d "/Applications/Karabiner-Elements.app" ]; then
    echo "⚠️  Karabiner driver not found."
    echo "   Kanata requires the virtual HID driver to intercept and emit keystrokes on macOS."
    echo "   Installing Karabiner-Elements cask (requires sudo password)..."
    brew install --cask karabiner-elements || {
        echo ""
        echo "⚠️  If the installer asked for sudo password or failed, please run:"
        echo "    brew install --cask karabiner-elements"
    }
else
    echo "✅ Karabiner driver/app is installed."
fi

# 4. Symlink Config
echo ""
echo "🔗 Setting up configuration symlink..."
mkdir -p "$CONFIG_DIR"
ln -sf "$SRC_FILE" "$CONFIG_FILE"
echo "   $SRC_FILE -> $CONFIG_FILE"

# 5. Validate Syntax
echo ""
echo "🧪 Validating Kanata configuration syntax..."
kanata --check -c "$CONFIG_FILE"
echo "✅ Configuration syntax is 100% valid!"

echo ""
echo "========================================================"
echo "                  REQUIRED PERMISSIONS                  "
echo "========================================================"
echo "macOS requires you to grant permissions to Kanata & the Driver:"
echo ""
echo "1. System Settings -> Privacy & Security -> Input Monitoring"
echo "   -> Enable 'kanata' and 'Karabiner' driver"
echo "2. System Settings -> Privacy & Security -> Accessibility"
echo "   -> Enable 'kanata' and 'Karabiner' driver"
echo ""
echo "========================================================"
echo "                       NEXT STEPS                       "
echo "========================================================"
echo "• Test live with hot-reloading:"
echo "    make test   (or: sudo kanata --cfg $CONFIG_FILE --cfg-watch)"
echo ""
echo "• Run as a background service on boot:"
echo "    make start  (or: sudo brew services start kanata)"
echo ""
echo "• Stop the background service:"
echo "    make stop   (or: sudo brew services stop kanata)"
echo ""
echo "========================================================"
