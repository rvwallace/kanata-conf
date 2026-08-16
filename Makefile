CONFIG_DIR := $(HOME)/.config/kanata
CONFIG_FILE := $(CONFIG_DIR)/kanata.kbd
SRC_FILE := $(CURDIR)/kanata.kbd

.PHONY: help install link check test start stop restart reload status

help:
	@echo "Kanata Configuration Manager"
	@echo ""
	@echo "Available commands:"
	@echo "  make install   Run full setup script (checks brew, driver, links config)"
	@echo "  make link      Symlink kanata.kbd into ~/.config/kanata/kanata.kbd"
	@echo "  make check     Validate configuration syntax"
	@echo "  make test      Run Kanata in foreground with live --cfg-watch reloading"
	@echo "  make start     Start background daemon via brew services"
	@echo "  make stop      Stop background daemon"
	@echo "  make restart   Restart background daemon"
	@echo "  make reload    Same as restart"
	@echo "  make status    Check background daemon status"
	@echo ""

install:
	./setup.sh

link:
	@mkdir -p $(CONFIG_DIR)
	@ln -sf $(SRC_FILE) $(CONFIG_FILE)
	@echo "Linked $(SRC_FILE) -> $(CONFIG_FILE)"

check:
	kanata --check -c $(SRC_FILE)

test: link check
	@echo "Starting Kanata in live-watch mode... (Ctrl+C to stop)"
	sudo kanata --cfg $(SRC_FILE) --cfg-watch

start: link check
	sudo brew services start kanata

stop:
	sudo brew services stop kanata

restart:
	sudo brew services restart kanata

reload: restart

status:
	sudo brew services info kanata
