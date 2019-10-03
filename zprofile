# vim:ft=zsh
#
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down



###################
#     Commands    #
###################

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

