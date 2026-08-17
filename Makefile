CONFIG_DIR := $(HOME)/.config/kanata
CONFIG_FILE := $(CONFIG_DIR)/kanata.kbd
SRC_FILE := $(CURDIR)/kanata.kbd

.PHONY: help install link check test permissions start stop restart reload status

help:
	@echo "Kanata Configuration Manager"
	@echo ""
	@echo "Available commands:"
	@echo "  make install      Run full setup script"
	@echo "  make link         Symlink kanata.kbd into ~/.config/kanata/kanata.kbd"
	@echo "  make check        Validate configuration syntax"
	@echo "  make permissions  Trigger macOS Accessibility permission prompt"
	@echo "  make test         Run Kanata in foreground with layer change logs"
	@echo "  make start        Start background daemon via brew services"
	@echo "  make stop         Stop background daemon"
	@echo "  make restart      Restart background daemon"
	@echo "  make reload       Same as restart"
	@echo "  make status       Check background daemon status"
	@echo ""

install:
	./setup.sh

permissions:
	@kanata --macos-request-permissions || true
	@open "x-apple.systempreferences:com.apple.preference.security?Privacy_ListenEvent" 2>/dev/null || true
	@open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility" 2>/dev/null || true

link:
	@mkdir -p $(CONFIG_DIR)
	@ln -sf $(SRC_FILE) $(CONFIG_FILE)
	@echo "Linked $(SRC_FILE) -> $(CONFIG_FILE)"

check:
	kanata --check -c $(SRC_FILE)

test: link check
	@echo "Starting Kanata in foreground mode... (Press Ctrl+C to stop)"
	sudo kanata --cfg $(SRC_FILE) --log-layer-changes

start: link check
	sudo brew services restart kanata

stop:
	sudo brew services stop kanata

restart:
	sudo brew services restart kanata

reload: restart

status:
	sudo brew services info kanata
