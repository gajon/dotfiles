# BASH OPTIONS & UTILS
# ---------------------------
#export EDITOR='mvim -f -c "au VimLeave * !open -a Terminal"'
export EDITOR='vim -f'
export PATH=${HOME}/.local/bin:${PATH}
export INPUTRC=${HOME}/.inputrc
export HOMEBREW_GITHUB_API_TOKEN=
export LC_ALL=en_US.UTF-8
export NPM_AUTH_TOKEN=

GPG_TTY=$(tty)
export GPG_TTY

# Use the silver searcher for FZF
# https://github.com/junegunn/fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# History control.
export HISTCONTROL=ignorespace:ignoredups
export HISTFILESIZE=2000
export HISTSIZE=2000

# OTHER OPTIONS
# ---------------------------
export HGMERGE="vimdiff --nofork"
export LIMPRUNTIME=${HOME}/.vim/limp/latest
#export WNHOME=/usr
export RLWRAP_HOME=${HOME}/.rlwrap/
export NNTPSERVER="news.eternal-september.org"

# Para aventones
export REDISTOGO_URL=redis://127.0.0.1:6379/

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi


if [ -r ~/.profile ]; then
    . ~/.profile;
fi
case "$-" in
    *i*)
        if [ -r ~/.bashrc ]; then
            . ~/.bashrc;
        fi
        ;;
esac
