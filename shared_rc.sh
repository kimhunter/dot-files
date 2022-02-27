PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

#include python user installs in path
if [[ -d "$HOME/Library/Python" ]]; then
    if [[ -d "$HOME/Library/Python/3.8/bin" ]]; then
        PATH="$PATH:$HOME/Library/Python/3.8/bin"
    elif [[ -d "$HOME/library/python/3.7/bin" ]]; then
        PATH="$PATH:$HOME/Library/Python/3.7/bin"
    elif [[ -d "$HOME/Library/Python/bin" ]]; then
        PATH="$PATH:$HOME/Library/Python/bin"
    fi
fi

export PATH=/opt/homebrew/bin:$PATH:~/.bin:~/Library/haskell/bin


export PYENV_ROOT="$HOME/.pyenv"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_AUTO_UPDATE_SECS=172800
export LESS="-R"
#export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export EDITOR='vim'
export GIT_EDITOR=$EDITOR
export MYSQL_PS1="mysql \U>\_"
export PYTHONSTARTUP=$HOME/.pythonrc.py
export RUBYOPT="rubygems"
#export VISUAL="mate -r"

smiley_status() {
  # prompt value based on retval
  if [ $? = 0 ]; then
    export SMILEY="\001\033[0m\002$"
  else
    export SMILEY="\001\033[31m\002$\001\033[0m\002"
  fi
}

function evil_git_dirty {
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo " *"
}

# include a non versioned bashrc
if [[ -f .other_bashrc ]]; then
    source .other_bashrc
fi

# Change dir to closest parent
function pcd() {
    cd "$1" || pcd "$(dirname "$1")"
}

if [[ -e "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi
