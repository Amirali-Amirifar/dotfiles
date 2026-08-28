XDG_CONFIG_HOME ?= $(HOME)/.config
ROOT := $(CURDIR)
CONFIGS := nvim git kitty ripgrep bat fd

.PHONY: install $(CONFIGS) zsh tmux plugins update-plugins

install: $(CONFIGS) zsh tmux

define link
	@mkdir -p "$(dir $(2))"
	@if [ -e "$(2)" ] && [ ! -L "$(2)" ]; then \
		if [ -e "$(2).bak" ] || [ -L "$(2).bak" ]; then \
			echo "refusing to replace existing backup $(2).bak" >&2; \
			exit 1; \
		fi; \
		mv "$(2)" "$(2).bak"; \
		echo "backed up $(2) to $(2).bak"; \
	fi
	@ln -sfn "$(1)" "$(2)"
endef

$(CONFIGS):
	$(call link,$(ROOT)/.config/$@,$(XDG_CONFIG_HOME)/$@)

zsh: plugins
	$(call link,$(ROOT)/.config/zsh,$(XDG_CONFIG_HOME)/zsh)
	$(call link,$(ROOT)/.config/zsh/.zshenv,$(HOME)/.zshenv)

tmux:
	$(call link,$(ROOT)/.tmux.conf,$(HOME)/.tmux.conf)

plugins:
	@git submodule update --init --recursive

update-plugins:
	@git submodule update --remote --merge
