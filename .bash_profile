# BASH OPTIONS & UTILS
# ---------------------------
export EDITOR=vim
export PATH=${HOME}/Clojure:${HOME}/jython2.5.0:${HOME}/Python/site-packages/django/bin:${PATH}
export INPUTRC=${HOME}/.inputrc

# Aliases.
alias grep="grep --color=auto"
alias mv="mv -i"
alias cp="cp -i"
alias ll="ls --group-directories-first -lhG"
alias lt="ls -lhtr"
alias rxvt16="rxvt -ls +sb -sl 1000 -rv -fn -xos4-terminus-medium-r-normal--16-160-72-72-c-80-iso8859-1"
alias rxvt20="rxvt -ls -rv +sb -sl 1500 -fn -xos4-terminus-medium-r-normal-*-20-200-72-72-c-100-iso8859-1"
alias mq='hg -R $(hg root)/.hg/patches'

# History control.
export HISTCONTROL=ignorespace:ignoredups
export HISTFILESIZE=2000
export HISTSIZE=2000

alias h="fc -l"
alias r="fc -s"

shopt -s histappend
shopt -s histreedit
shopt -s histverify


# OTHER OPTIONS
# ---------------------------
export PYTHONPATH="${HOME}/Python/:${HOME}/Python/site-packages/"
export PYTHONDOCS="/usr/doc/python-2.5.2/html/Python-Docs-2.5.2/"
export HGMERGE="gvimdiff --nofork"
#export LIMPRUNTIME=${HOME}/.limp/latest
export WNHOME=/usr
export RLWRAP_HOME=${HOME}/.rlwrap/
export NNTPSERVER="news.eternal-september.org"

# Oracle JDeveloper
# ---------------------------
export JDEV_USER_DIR=${HOME}/jdevhome

# ORACLE
# ---------------------------
# These are needed to use the cx_Oracle python adapter.
#ORACLE_HOME=/usr/lib/oracle/xe/app/oracle/product/10.2.0/server
#LD_LIBRARY_PATH=${ORACLE_HOME}/lib
#export ORACLE_HOME LD_LIBRARY_PATH
#ORACLE_SID=XE
#PATH=${ORACLE_HOME}/bin:$PATH
#export ORACLE_HOME ORACLE_SID PATH LD_LIBRARY_PATH


# AUTOCOMPLETION
# ---------------------------
. ${HOME}/Python/site-packages/mercurial_src/contrib/bash_completion
. /usr/doc/mpc-0.12.1/mpc-bashrc


# Prompt and readline mode
# ---------------------------

set -o vi
case $TERM in
	xterm*)
	TITLEBAR='\[\033]0;\w\007\]'
	;;
	*)
	TITLEBAR=""
	;;
esac

# Color codes
WHITE="\e[0;37m"
GRAY="\e[0;30m"
RED="\e[0;31m"
GREEN="\e[0;32m"
ORANGE="\e[0;33m"
BLUE="\e[0;34m"
PINK="\e[0;35m"
CYAN="\e[0;36m"

# Bold colors
WHITE1="\e[1;37m"
GRAY1="\e[1;30m"
RED1="\e[1;31m"
GREEN1="\e[1;32m"
ORANGE1="\e[1;33m"
BLUE1="\e[1;34m"
PINK1="\e[1;35m"
CYAN1="\e[1;36m"

# Background colors
BLACKBG="\e[40m"
REDBG="\e[40m"
GREENBG="\e[40m"
YELLOWBG="\e[43m"
BLUEBG="\e[40m"
PINKBG="\e[40m"
CYANBG="\e[40m"
GRAYBG="\e[40m"

#export PS1="${TITLEBAR}\[\033[40;36m\]\!\[\033[32m\][\A]\[\033[33m\][\u:\W]\\$ \[\033[0m\]"

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

PROMPT_COMMAND="$(echo "$PROMPT_COMMAND"|sed -e's/PS1="`render_ps1`";//g')"
PROMPT_COMMAND='PS1="`render_ps1`";'"$PROMPT_COMMAND"

