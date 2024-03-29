# BASH OPTIONS & UTILS
# ---------------------------
#export EDITOR='mvim -f -c "au VimLeave * !open -a Terminal"'
export EDITOR='vim -f'
export PATH=/usr/local/sbin:/usr/local/bin:${HOME}/.local/bin:${PATH}
export PATH=/usr/local/Cellar/smlnj/110.75/libexec/bin:${PATH}
export INPUTRC=${HOME}/.inputrc

# History control.
export HISTCONTROL=ignorespace:ignoredups
export HISTFILESIZE=2000
export HISTSIZE=2000
export URBIT_HOME=${HOME}/urbit/urb

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

