# kanata-conf

> Unified, cross-keyboard layout configuration for macOS (built-in MacBook keyboard & NuPhy Air75).

This repository houses a declarative [Kanata](https://github.com/jtroo/kanata) keyboard mapping that runs identically across internal laptop keyboards and external mechanical keyboards, preserving muscle memory across all workflows.

---

## 🗺️ Layers & Layouts

### 1. Base Layer (Default)

* **`Caps Lock` Triple Function**:
  * **Single Tap**: `Escape`
  * **Double Tap**: `Caps Lock` toggle
  * **Hold**: Activates **Navigation Layer**
* **`Tab` Dual Function**:
  * **Tap**: `Tab`
  * **Hold**: **Hyper Key** (`Cmd + Option + Ctrl + Shift`) for window management / Raycast hotkeys
* **`Space` Dual Function**:
  * **Tap**: `Space`
  * **Hold**: Activates **Numpad & Symbols Layer**

---

### 2. Navigation & Editing Layer (Hold `Caps Lock`)

Vim navigation, dedicated scrolling, macOS text selection modifiers, and clipboard shortcuts without leaving the home row.

```text
┌────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────────┐
│ `  │ 1  │ 2  │ 3  │ 4  │ 5  │ 6  │ 7  │ 8  │ 9  │ 0  │ -  │ =  │  DEL   │
├────┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──────┤
│ TAB  │    │    │    │    │    │    │HOM │PGD │PGU │END │    │    │      │
├──────┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴──────┤
│ [HOLD]│CTL │ALT │CMD │SFT │    │ ←  │ ↓  │ ↑  │ →  │    │    │   RET    │
├───────┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴──────────┤
│  SHIFT  │UND │CUT │CPY │PST │    │    │    │    │    │    │    SHIFT    │
├─────┬───┴─┬──┴──┬─┴────┴────┴────┴────┴────┴────┴────┴┬───┴─┬─────┬─────┤
│ CTL │ OPT │ CMD │                SPACE                │ CMD │ OPT │ CTL │
└─────┴─────┴─────┴─────────────────────────────────────┴─────┴─────┴─────┘
```

| Key | Action | Purpose |
| :--- | :--- | :--- |
| **`H` `J` `K` `L`** | `←` `↓` `↑` `→` | Full directional navigation |
| **`U` `I` `O` `P`** | `Home` `PgDn` `PgUp` `End` | Dedicated document and scroll navigation |
| **`A` `S` `D` `F`** | `Ctrl` `Alt` `Cmd` `Shift` | Modifiers optimized for macOS text selection |
| **`Z` `X` `C` `V`** | `Cmd+Z` `Cmd+X` `Cmd+C` `Cmd+V` | macOS Undo, Cut, Copy, Paste shortcuts |
| **`Backspace`** | `Forward Delete` | Forward delete character (missing on MacBook) |

> **Text Selection Pro-Tip**:
> * `Caps (Hold)` + `F` (Shift) + `L` $\rightarrow$ Select characters right.
> * `Caps (Hold)` + `S` (Alt) + `L` $\rightarrow$ Jump forward one word.
> * `Caps (Hold)` + `D` (Cmd) + `L` $\rightarrow$ Jump to end of line.
> * `Caps (Hold)` + `D` + `F` (Cmd+Shift) + `L` $\rightarrow$ Select to end of line with index + middle fingers.

---

### 3. Numpad & Symbols Layer (Hold `Space`)

Turns the right hand into a standard 10-key numpad and provides common programming symbols on the left hand.

```text
┌────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────────┐
│ `  │ 1  │ 2  │ 3  │ 4  │ 5  │ 6  │ 7  │ 8  │ 9  │ 0  │ -  │ =  │  BSPC  │
├────┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──────┤
│ TAB  │ !  │ @  │ #  │ $  │ %  │    │ 7  │ 8  │ 9  │ +  │ -  │    │      │
├──────┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴──────┤
│  CAPS │ ^  │ &  │ *  │ (  │ )  │    │ 4  │ 5  │ 6  │ *  │ /  │    =     │
├───────┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴──────────┤
│  SHIFT  │ ~  │ `  │ [  │ ]  │ |  │ 0  │ 1  │ 2  │ 3  │ .  │    SHIFT    │
├─────┬───┴─┬──┴──┬─┴────┴────┴────┴────┴────┴────┴────┴┬───┴─┬─────┬─────┤
│ CTL │ OPT │ CMD │                [HOLD]               │ CMD │ OPT │ CTL │
└─────┴─────┴─────┴─────────────────────────────────────┴─────┴─────┴─────┘
```

---

## 🚀 Installation & Setup

### Prerequisites
* [Homebrew](https://brew.sh)

### First-Time Installation
Clone and run the automated setup:
```bash
cd ~/silentcastle/projects/kanata-conf
make install
```

`make install` automatically:
1. Installs `kanata` via Homebrew.
2. Installs the standalone `Karabiner-DriverKit-VirtualHIDDevice` (v6.2.0).
3. Configures the system `LaunchDaemon` for driver communication.
4. Symlinks `~/.config/kanata/kanata.kbd` to this repo.
5. Validates syntax and starts the background service.

### macOS Permissions
Ensure permissions are enabled under **System Settings > Privacy & Security**:
* **Input Monitoring**: Toggle **ON** for `kanata`.
* **Accessibility**: Toggle **ON** for `kanata`.

---

## 🧩 DriverKit & Kanata Compatibility Matrix

Kanata communicates with the Karabiner DriverKit system extension via an internal IPC client protocol. DriverKit versions must match Kanata's compiled protocol version (documented in [Kanata macOS Setup Guide](https://github.com/jtroo/kanata/blob/main/docs/setup-macos.md#2-install-karabiner-driverkit-virtualhiddevice)):

| Kanata Version | IPC Protocol | Required Karabiner DriverKit | Notes |
| :--- | :--- | :--- | :--- |
| **`v1.12.x` and below** | Protocol 5 | **`v6.2.0`** | Current Homebrew stable version |
| **`v1.13.0` and above** | Protocol 7 | **`v8.0.0` / `v8.2.0`+** | Uses updated `karabiner-driverkit` crate |

> [!NOTE]
> `make install` (`setup.sh`) automatically detects your installed Kanata version (`kanata --version`) and downloads the exact matching DriverKit package without manual intervention.

---

## 🛠️ Daily Workflow Commands

```bash
# Restart / reload background service after editing kanata.kbd
make reload

# Check background daemon status & health
make status

# Stop the background service
make stop

# Start the background service
make start

# Test in foreground with live layer change logs
make test
```

---

## ⚙️ Customization

Edit [`kanata.kbd`](./kanata.kbd) to adjust tap-hold timings or reassign keys:
* **Tap-Hold Timings (`defvar`)**: Easily tweak `tap-time` (180ms), `hold-time` (200ms), and `space-hold-time` (230ms) directly in the `(defvar ...)` block at the top of [`kanata.kbd`](./kanata.kbd).
* **Symlink**: `~/.config/kanata/kanata.kbd` links directly to `kanata.kbd` in this repository (`make link`).
