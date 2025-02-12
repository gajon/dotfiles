# Aliases.
alias grep="grep --color=auto"
alias mv="mv -i"
alias cp="cp -i"
alias ls="ls -FbTG"
alias ll="ls  -lho"
alias lt="ls -lhtr"
alias mq='hg -R $(hg root)/.hg/patches'
alias tree="tree -A -C"
alias iphonesim="open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app"

alias b="bundle exec"
alias gl="git log"
alias gs="git status"
alias gh="git h"
alias gha="git ha"
alias gd="git diff"
alias gds="git diff --staged"
alias gai="git add -i"
alias gpo="git push origin master"
alias gcm="git commit -S -m"


#alias gs='git status '
#alias ga='git add '
#alias gb='git branch '
#alias gc='git commit'
#alias gd='git diff'
#alias go='git checkout '
#alias gk='gitk --all&'

# After listing the history, you can repeat a command with !n where n is the
# command number. You can also pull an argument from the last command with !:
#    $ ls one two three
#    $ echo !:1
# -> $ echo one
#    $ echo !:0 !:3 !:2 asdf
# -> $ echo ls three two asdf
alias h="fc -l"
alias r="fc -s"


shopt -s histappend
shopt -s histreedit
shopt -s histverify

# Taken from http://jeetworks.org/node/97
# Ctrl-p: search in previous history
bind 'Control-p: history-search-backward'
bind -m vi-insert 'Control-p: history-search-backward'
bind -m vi-command 'Control-p: history-search-backward'

# Ctrl-n: search in next history
bind 'Control-n: history-search-forward'
bind -m vi-insert 'Control-n: history-search-forward'
bind -m vi-command 'Control-n: history-search-forward'



# AUTOCOMPLETION
# ---------------------------
#. ${HOME}/Python/site-packages/mercurial_src/contrib/bash_completion
#. /usr/doc/mpc-0.12.1/mpc-bashrc


# Prompt and readline mode
# ---------------------------
set -o vi
case $TERM in
	xterm* | screen*)
	TITLEBAR='\[\033]0;\w\007\]'
	;;
	*)
	TITLEBAR=""
	;;
esac

# Color codes
WHITE="\[\e[0;37m\]"
GRAY="\[\e[0;30m\]"
RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
ORANGE="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
PINK="\[\e[0;35m\]"
CYAN="\[\e[0;36m\]"

# Bold colors
WHITE1="\[\e[1;37m\]"
GRAY1="\[\e[1;30m\]"
RED1="\[\e[1;31m\]"
GREEN1="\[\e[1;32m\]"
ORANGE1="\[\e[1;33m\]"
BLUE1="\[\e[1;34m\]"
PINK1="\[\e[1;35m\]"
CYAN1="\[\e[1;36m\]"

# Background colors
BLACKBG="\[\e[40m\]"
REDBG="\[\e[40m\]"
GREENBG="\[\e[40m\]"
YELLOWBG="\[\e[43m\]"
BLUEBG="\[\e[40m\]"
PINKBG="\[\e[40m\]"
CYANBG="\[\e[40m\]"
GRAYBG="\[\e[40m\]"

gitStatus() { git diff --quiet 2> /dev/null || echo '*'; }
#gitBranch() { git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/*\(.*\)/ >\1$(gitStatus)/"; }
gitBranch() { git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/*\(.*\)/\1 /"; }

#export PS1="${TITLEBAR}\[\033[40;36m\]\!\[\033[32m\][\A]\[\033[33m\][\u:\W]\\$ \[\033[0m\]"
export PS1="${TITLEBAR}${CYAN}\!${GREEN}[\A]${BLUE}[\u:\w]${RED}\$(gitBranch)${RED}\\$ \[\e[0m\]"
#export PS1="${TITLEBAR}${GREEN}[\A]${BLUE}[\u:\w]${BLUE}\\$ \[\e[0m\]"
#export PS1="${TITLEBAR}[\A][\u:\w]\$(gitBranch)\\$ "

# Taken and modified from http://stevelosh.com/projects/hg-prompt/
hg_ps1() {
  # Since there's a Mercurial repository (my dotfiles) sitting right under
  # my $HOME folder, anytime I'm on any non HG managed folder the hg prompt
  # would appear. This test avoids that.
  branch=`hg root 2> /dev/null`
  if [ "x${branch}" != "x${HOME}" ]; then
    hg prompt "\n${GRAYBG}${WHITE1}HG ${BLACKBG}${WHITE}{root|basename} \
${CYAN}{branch} \
${GREEN}r:{rev}{${GREEN1} [merge:{rev|merge}]} \
${RED}{{status}}\
{${ORANGE}not-tip{update}}${WHITE}: " 2> /dev/null
  fi
}

render_ps1() {
  echo "${TITLEBAR}${CYAN}\!${GREEN}[\A]${ORANGE}[\u:\W]\\$ $(hg_ps1)\e[0m"
}

#PROMPT_COMMAND="$(echo "$PROMPT_COMMAND"|sed -e's/PS1="`render_ps1`";//g')"
#PROMPT_COMMAND='PS1="`render_ps1`";'"$PROMPT_COMMAND"

#. /etc/profile.d/coreutils-dircolors.sh
#. /etc/profile.d/mc.sh

# Bash DirB
# http://www.linuxjournal.com/article/10585
source ~/.bashDirB


#alias fortune="/usr/local/bin/fortune -a 70% ~/.fortunes 30% all"
#echo; fortune; echo

complete -C aws_completer aws

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
