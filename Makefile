XDG_CONFIG_HOME ?= $(HOME)/.config
ROOT := $(CURDIR)
CONFIGS := nvim git kitty ripgrep bat fd zsh

.PHONY: install plugins update-plugins

install: plugins
	@mkdir -p "$(XDG_CONFIG_HOME)"
	@for name in $(CONFIGS); do \
		target="$(XDG_CONFIG_HOME)/$$name"; \
		if [ -e "$$target" ] && [ ! -L "$$target" ]; then \
			echo "refusing to replace $$target" >&2; \
			exit 1; \
		fi; \
		ln -sfn "$(ROOT)/.config/$$name" "$$target"; \
	done
	@if [ -e "$(HOME)/.zshenv" ] && [ ! -L "$(HOME)/.zshenv" ]; then \
		echo "refusing to replace $(HOME)/.zshenv" >&2; \
		exit 1; \
	fi
	@ln -sfn "$(ROOT)/.config/zsh/.zshenv" "$(HOME)/.zshenv"
	@if [ -e "$(HOME)/.tmux.conf" ] && [ ! -L "$(HOME)/.tmux.conf" ]; then \
		echo "refusing to replace $(HOME)/.tmux.conf" >&2; \
		exit 1; \
	fi
	@ln -sfn "$(ROOT)/.tmux.conf" "$(HOME)/.tmux.conf"

plugins:
	@git submodule update --init --recursive

update-plugins:
	@git submodule update --remote --merge
