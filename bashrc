
# default path so if i reload i don't get slow downs
export PYENV_ROOT="$HOME/.pyenv"
export GOPATH=$HOME/Projects/go

PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
PATH=$PYENV_ROOT/bin:$PATH:~/.bin:~/Library/haskell/bin:$GOPATH/bin
export PATH=$PATH


smiley_status() {
  if [ $? = 0 ]; then
    export SMILEY="\001\033[32m\002$\001\033[0m\002"
  else
    export SMILEY="\001\033[31m\002$\001\033[0m\002"
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

BW_PREFIX=`brew --prefix`
#source files if exist
bash_completion_files="
    /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
    /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh
    $BW_PREFIX/etc/bash_completion
    $BW_PREFIX/etc/bash_completion.d/subversion
    $BW_PREFIX/etc/bash_completion.d/git-prompt.sh
    $BW_PREFIX/etc/bash_completion.d/hg-completion.bash
    $BW_PREFIX/Library/Contributions/brew_bash_completion.sh
    $BW_PREFIX/etc/bash_completion.d/django
"
#$BW_PREFIX/etc/bash_completion.d/git-completion.bash

for complete_file in $bash_completion_files; do
    if [ -f $complete_file ]; then . $complete_file; fi
done

#set -o vim
# history (bigger size, no duplicates, always append):
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

if [[ -f .other_bashrc ]]; then
    source .other_bashrc
fi

eval "$(rbenv init -)"
eval "$(pyenv init -)"

export PYTHONSTARTUP=$HOME/.pythonrc.py

