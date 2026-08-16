# kanata-conf

> Unified, cross-keyboard layout configuration for macOS (built-in MacBook keyboard & NuPhy Air75).

This repository houses a declarative [Kanata](https://github.com/jtroo/kanata) keyboard mapping that runs identically across internal laptop keyboards and external mechanical keyboards, preserving muscle memory across all workflows.

---

## 🗺️ Layers & Layouts

### 1. Base Layer (Default)

* **`Caps Lock` Dual Function**:
  * **Tap**: `Escape`
  * **Hold**: Activates **Navigation Layer**
* **`Tab` Dual Function**:
  * **Tap**: `Tab`
  * **Hold**: **Hyper Key** (`Cmd + Option + Ctrl + Shift`) for window management / Raycast hotkeys
* **`Space` Dual Function**:
  * **Tap**: `Space`
  * **Hold**: Activates **Numpad & Symbols Layer**

---

### 2. Navigation Layer (Hold `Caps Lock`)

Vim navigation, word jumping, and forward delete right at your fingertips without leaving the home row.

```text
┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────┐
│   │   │   │   │   │   │   │   │   │   │   │   │   │  DEL  │
├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─────┤
│     │   │   │   │   │   │HOM│PGD│PGU│END│   │   │   │     │
├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤
│[HOLD]│CMD│ALT│SFT│CTL│   │ ← │ ↓ │ ↑ │ → │   │   │       │
├──────┴─┬─┴──┬┴──┬┴──┬┴──┬┴──┬┴──┬┴──┬┴──┬┴──┬┴──┬┴───────┤
│        │    │   │   │   │   │   │   │   │   │   │        │
└────────┴────┴───┴───┴───┴───┴───┴───┴───┴───┴───┴────────┘
```

| Key | Action | Purpose |
| :--- | :--- | :--- |
| **`H` `J` `K` `L`** | `←` `↓` `↑` `→` | Full directional navigation |
| **`Y`** | `Home` | Jump to start of line / document |
| **`O`** | `End` | Jump to end of line / document |
| **`U`** | `Page Down` | Scroll down |
| **`I`** | `Page Up` | Scroll up |
| **`Backspace`** | `Forward Delete` | Delete character in front of cursor |
| **`A` `S` `D` `F`** | `Cmd` `Alt` `Shift` `Ctrl` | Modifiers for one-hand selection and jumping |

> **Text Selection Pro-Tip**:
> * `Caps (Hold)` + `D` (Shift) + `L` $\rightarrow$ Select characters right.
> * `Caps (Hold)` + `S` (Alt) + `L` $\rightarrow$ Jump forward one word.
> * `Caps (Hold)` + `S` + `D` + `L` $\rightarrow$ Select word by word.

---

### 3. Numpad & Symbols Layer (Hold `Space`)

Turns the right hand into a standard 10-key numpad and provides common programming symbols on the left hand.

```text
┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────┐
│   │   │   │   │   │   │   │   │   │   │   │   │   │       │
├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─────┤
│     │ ! │ @ │ # │ $ │ % │   │ 7 │ 8 │ 9 │ + │ - │   │     │
├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤
│      │ ^ │ & │ * │ ( │ ) │   │ 4 │ 5 │ 6 │ * │ / │   =   │
├──────┴─┬─┴──┬┴──┬┴──┬┴──┬┴──┬┴──┬┴──┬┴──┬┴──┬┴──┬┴───────┤
│        │ ~  │ ` │ [ │ ] │ | │ 0 │ 1 │ 2 │ 3 │ . │        │
└────────┴────┴───┴───┴───┴───┴───┴───┴───┴───┴───┴────────┘
```

---

## 🚀 Quick Start & Management

### Prerequisites
* [Homebrew](https://brew.sh)
* Karabiner VirtualHIDDevice Driver (installed via `brew install --cask karabiner-elements`)

### First-Time Setup
Run the setup script from the repo directory:
```bash
make install
```

### macOS System Permissions
1. Open **System Settings > Privacy & Security > Input Monitoring**:
   * Enable `kanata` and `Karabiner`.
2. Open **System Settings > Privacy & Security > Accessibility**:
   * Enable `kanata` and `Karabiner`.

---

## 🛠️ Daily Workflow Commands

```bash
# Test changes live with auto-reloading as you edit kanata.kbd
make test

# Start background service on boot
make start

# Restart / reload background service after updating config
make reload

# Stop the background service
make stop

# Check background daemon status
make status
```

---

## ⚙️ Customization

Edit [`kanata.kbd`](./kanata.kbd) to adjust tap-hold timings or reassign keys:
* **Tap-Hold Timings**: Defaults are `180ms` for Caps Lock and `200ms` for Space/Tab. Increase to `220ms` if you accidentally trigger layers during fast typing.
* **Symlink**: `~/.config/kanata/kanata.kbd` links directly to `kanata.kbd` in this repository.
