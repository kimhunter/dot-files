# vim:ft=zsh
#
# Login shell setup - environment variables and PATH

if ! [[ $PATH == */opt/homebrew/sbin* ]]; then
    export PATH="/opt/homebrew/sbin:$PATH"
fi
