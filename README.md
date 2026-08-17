# kanata-conf

> Unified keyboard configuration for macOS (MacBook built-in keyboard and NuPhy Air75).

This repository contains a [Kanata](https://github.com/jtroo/kanata) configuration for macOS. It maps keys identically across internal laptop keyboards and external keyboards.

---

## 🗺️ Layers & Layouts

### 1. Base Layer (Default)

* **`Caps Lock`**:
  * **Tap**: `Escape`
  * **Double Tap**: `Caps Lock`
  * **Hold**: Navigation & Editing Layer
* **`Tab`**:
  * **Tap**: `Tab`
  * **Hold**: Hyper Key (`Cmd + Option + Ctrl + Shift`)
* **`Space`**:
  * **Tap**: `Space`
  * **Hold**: Numpad & Symbols Layer

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
| **`H` `J` `K` `L`** | `←` `↓` `↑` `→` | Directional navigation |
| **`U` `I` `O` `P`** | `Home` `PgDn` `PgUp` `End` | Document and scroll navigation |
| **`A` `S` `D` `F`** | `Ctrl` `Alt` `Cmd` `Shift` | Modifiers for macOS text selection |
| **`Z` `X` `C` `V`** | `Cmd+Z` `Cmd+X` `Cmd+C` `Cmd+V` | Undo, Cut, Copy, and Paste shortcuts |
| **`Backspace`** | `Forward Delete` | Forward delete character |

> **Text Selection**:
> * `Caps (Hold)` + `F` (Shift) + `L` $\rightarrow$ Select characters right.
> * `Caps (Hold)` + `S` (Alt) + `L` $\rightarrow$ Move forward one word.
> * `Caps (Hold)` + `D` (Cmd) + `L` $\rightarrow$ Move to end of line.
> * `Caps (Hold)` + `D` + `F` (Cmd+Shift) + `L` $\rightarrow$ Select to end of line with index and middle fingers.

---

### 3. Numpad & Symbols Layer (Hold `Space`)

A 10-key numeric keypad on the right hand and common programming symbols on the left hand.

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
Clone the repository and run setup:
```bash
cd ~/silentcastle/projects/kanata-conf
make install
```

`make install` performs these setup steps:
1. Installs `kanata` with Homebrew.
2. Installs the matching `Karabiner-DriverKit-VirtualHIDDevice` package.
3. Sets up the system `LaunchDaemon` for driver communication.
4. Symlinks `~/.config/kanata/kanata.kbd` to this repository.
5. Checks configuration syntax and starts the background service.

### macOS Permissions
Kanata requires two permissions in **System Settings > Privacy & Security** (run `make permissions` to auto-open these panes):

1. **Input Monitoring** (`Privacy & Security > Input Monitoring`):
   * Toggle **`kanata`** to **ON** (blue).
   * *If `kanata` is not listed:* Click `+`, press <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>G</kbd>, paste `/opt/homebrew/bin/kanata`, click **Open**, and toggle it **ON**.
2. **Accessibility** (`Privacy & Security > Accessibility`):
   * Ensure **`kanata`** is toggled **ON**.

Once granted, start or reload the background service with `make start` or `make reload`.

---

## 🧩 DriverKit & Kanata Compatibility Matrix

Kanata communicates with the Karabiner DriverKit extension through an internal IPC protocol. The DriverKit version must match the protocol version in Kanata. See the [Kanata macOS Setup Guide](https://github.com/jtroo/kanata/blob/main/docs/setup-macos.md#2-install-karabiner-driverkit-virtualhiddevice):

| Kanata Version | IPC Protocol | Required Karabiner DriverKit | Notes |
| :--- | :--- | :--- | :--- |
| **`v1.12.x` and below** | Protocol 5 | **`v6.2.0`** | Homebrew stable version |
| **`v1.13.0` and above** | Protocol 7 | **`v8.0.0` / `v8.2.0`+** | Uses updated `karabiner-driverkit` crate |

> [!NOTE]
> The `setup.sh` script detects your installed `kanata` version and downloads the matching DriverKit package automatically.

---

## 🛠️ Daily Workflow Commands

```bash
# Restart background service after editing kanata.kbd
make reload

# Check background daemon status
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

Edit [`kanata.kbd`](./kanata.kbd) to change timings or key mappings:
* **Tap-Hold Timings (`defvar`)**: Change `tap-time` (180ms), `hold-time` (200ms), and `space-hold-time` (230ms) in the `(defvar ...)` block at the top of [`kanata.kbd`](./kanata.kbd).
* **Symlink**: Run `make link` to link `~/.config/kanata/kanata.kbd` to [`kanata.kbd`](./kanata.kbd) in this repository.
