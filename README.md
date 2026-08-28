# dotfiles

My setup for Zsh, Neovim, Git, Kitty, tmux, ripgrep, bat, and fd. I use macOS
most of the time, but try to keep the shell config working on Ubuntu too.

This repo only links the config files. It does not install any packages.

## Install

You need Git, Make, and Zsh to get started. Clone the repo and run `make`:

```sh
git clone https://github.com/Amirali-Amirifar/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
make
```

Run a single target if you only want part of the setup, for example `make nvim`,
`make zsh`, or `make tmux`.

If a destination already contains a real file or directory, it is moved to the
same path with `.bak` appended. The Makefile stops if that backup already exists.

For Git identity and machine-specific shell settings:

```sh
cp .config/git/local.example .config/git/local
cp .config/zsh/local.zsh.example .config/zsh/local.zsh
```

These copies are ignored by Git. Interactive-only Zsh settings can go in
`.config/zsh/local.zshrc` too.

To pull newer versions of the Zsh plugins, run `make update-plugins`.
