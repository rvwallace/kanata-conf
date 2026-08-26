# Changelog

This file documents all notable changes to the `kanata-conf` configuration.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### 2026-08-25

- Added `CHANGELOG.md` following Keep a Changelog standard and updated `README.md`.

### 2026-08-17

- Improved macOS permissions handling and added `make permissions` target to open System Settings directly.
- Enhanced launchd background service lifecycle and restart handling in `setup.sh`.

### 2026-08-16

- Modernized Navigation & Editing layer (`(defvar ...)` timings, `layer-while-held`, home-row macOS text selection modifiers, and clipboard shortcuts).
- Replaced 4-row layout diagrams in `README.md` with aligned 5-row ANSI keyboard grids.
- Streamlined documentation and added daily workflow commands reference.

### 2026-08-15

- Initial repository release with unified macOS keyboard configuration for MacBook built-in keyboard and NuPhy Air75.
- Added dynamic Karabiner DriverKit version matching based on installed `kanata` version (DriverKit v6.2.0 for Protocol 5, v8.x for Protocol 7).
- Added `org.pqrs.karabiner.driverkit-virtualhiddevice.plist` LaunchDaemon for system service management.
- Added DriverKit and Kanata protocol compatibility table to `README.md`.
