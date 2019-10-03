# vim:ft=zsh
#
if [[ -r ~/.shared_rc.sh ]]; then
    . ~/.shared_rc.sh
fi
if [[ -r ~/.aliases.sh ]]; then
    . ~/.aliases.sh
fi

OS_VERSION=$(sw_vers -buildVersion)

###################
#     Options     #
###################
unsetopt beep
setopt autocd


##################
#     Prompt     #
##################

# allow easy change of prompt
autoload -Uz promptinit
promptinit

export TERM=xterm-256color

# switch our the vcs variable for an isDirty value
function +vi-evil_git_dirty {
    if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]; then
        hook_com[vcs]=' *'
    else
        hook_com[vcs]=''
    fi
}

# Load version control information
# Set up the prompt (with git branch name)
autoload -Uz vcs_info
# Format the vcs_info_msg_0_ variable
#zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:git:*' formats '(%b %u)'
zstyle ':vcs_info:git+set-message:*' hooks evil_git_dirty
zstyle ':vcs_info:git:*' formats '%F{red}(%b%s)%f'
precmd() { vcs_info }
setopt PROMPT_SUBST
PROMPT=$'%m:$OS_VERSION %~ ${vcs_info_msg_0_} %v\n$ '

# Git stuff
PERSISTENT_DEV_DIR="$HOME/.xcdev"
GIT_EXE=$PERSISTENT_DEV_DIR/usr/libexec/git-core/git
alias nogit="$GIT_EXE"

##################
#    History     #
##################
setopt NOMATCH
setopt histignorespace autoresume histignoredups pushdsilent noclobber
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history
# Case insensitive tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# line up/down searching with current text search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down



###################
#     Commands    #
###################

# cd to directories in these places, if name typed
cdpath=( ~/Projects/ ~ )

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey -v


####################
#    Completion    #
####################

setopt complete_in_word
setopt list_ambiguous
setopt completealiases
setopt correct
autoload -U compinit
compinit

