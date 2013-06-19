
# default path so if i reload i don't get slow downs
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
PATH=$PATH:~/.bin:~/Library/haskell/bin:/usr/texbin
export PATH=$PATH
#export CC=$(which clang)
# For mercurial
export PYTHONPATH=/usr/local/lib/python2.5/site-packages:$PYTHONPATH

export APPENGINE_SDK_HOME=/opt/appengine-java-sdk-1.3.4

smiley_status() {
  if [ $? = 0 ]; then
    export SMILEY="\001\033[32m\002⚡\001\033[0m\002"
  else
    export SMILEY="\001\033[31m\002☢\001\033[0m\002"
  fi
}

export PS1='$(hostname -s): \w $(__git_ps1 " \[${COLOR_RED}\](%s$(evil_git_dirty))\[${COLOR_NC}\]")\n$(echo -ne $SMILEY) '
export LESS="-R"
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export EDITOR='vim'
export GIT_EDITOR=$EDITOR
#export VISUAL="mate -r"
export JAVA_OPTS="-Dfile.encoding=UTF-8"

export RUBYOPT="rubygems"

verify_not_alias() {
	last=`history 1`
	aliases=`alias`
	ruby ~/Projects/dot-files/verify.rb "$aliases" "$last"
}

function evil_git_dirty {
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo " *"
}


export PROMPT_COMMAND='smiley_status'
#export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD}"; echo -ne "\007"; verify_not_alias' 

#export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD}"; echo -ne "\007"'

# readline settings
bind "set completion-ignore-case on" 
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# Turn on advanced bash completion if the file exists (get it here: http://www.caliban.org/bash/index.shtml#completion)
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi
# Git completion
git_completion=/usr/local/etc/bash_completion.d/git-completion.bash
if [ -f $git_completion ] ; then 
    source $git_completion;
    source /usr/local/etc/bash_completion.d/git-prompt.sh;
fi

# Brew Completion
brew_completion=`brew --prefix`/Library/Contributions/brew_bash_completion.sh
if [ -f $brew_completion ] ; then source $brew_completion; fi

#set -o vim
# history (bigger size, no duplicates, always append):
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

eval "$(rbenv init -)"
