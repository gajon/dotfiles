# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR='vim -f'
export HOMEBREW_GITHUB_API_TOKEN=
export NPM_AUTH_TOKEN=
export GPG_TTY=$TTY
export PATH="$PATH:$HOME/src/utility-scripts"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"

export GITHUB_TOKEN=

# https://github.com/folke/tokyonight.nvim/tree/main/extras/fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#2d3f76 \
  --color=bg:#1e2030 \
  --color=border:#589ed7 \
  --color=fg:#c8d3f5 \
  --color=gutter:#1e2030 \
  --color=header:#ff966c \
  --color=hl+:#65bcff \
  --color=hl:#65bcff \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#ff966c \
  --color=spinner:#ff007c \
"

# Created by `pipx` on 2025-01-05 21:18:38
export PATH="$PATH:/Users/gajon/.local/bin"
