alias ls='ls -G'
alias la='ls -lah'
alias ll='ls -lah'
alias ..='cd ..;'
alias ...='.. ..'
alias dfh="df -h"
alias icd="cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/"
alias du1="du -hd1"
alias ea='mvim -f ~/.aliases.sh && source ~/.aliases.sh'
alias ka="killall"
alias mate="mate -r"
alias o="open"
alias s="screen"
alias systail='tail -f /var/log/system.log'
alias vi="vim"
alias origfind="find . -name '*.orig'"
alias whats_open="sudo lsof -i -n -P | grep LISTEN"

alias FinderZip="ditto -c -k --sequesterRsrc --keepParent" # params AppName.app AppName.zip Zip a file just like Finder does

# Development
alias ox="xcselect -o"
alias svnig="svn propedit svn:ignore"
alias cff="clang-format -style=file"
alias fjson="python -mjson.tool"
alias r='rake'
alias kax="ka Xcode"
alias glat="git --no-pager log -n3"
alias mybranches="git branch | grep -E kim | grep -v '/exp/'"
alias xcwhich="xcode-select -print-path; xcodebuild -version"

alias xcrmdd="rm -rdf ~/NoBackup/Xcode"
alias xcb="xcodebuild -jobs 8"
alias xcb-debug="time xcodebuild -jobs 8 -configuration Debug"
alias goo="go"

# Git
# alias gl='git pull'
# alias gs='git status -sb'
# alias glr='git pull --rebase'
# alias glg='git log --oneline --decorate'
# alias gsu='git submodule update'
# alias gp='git push'
# alias gpa='git push-all' # see [alias] in ~/.gitconfig
# alias ga='git add'
# alias gaa='git add -A'
# alias gc='git commit -v'
# alias gb='git branch'
# alias gba='git branch -a'
# alias gco='git checkout'
# alias gm='git checkout master'
# alias gitx="open -b nl.frim.GitX"
# alias gm='git merge --no-ff'
# alias gfo='git fetch origin'
# alias grb='git rebase'
# alias gdi='git diff --staged'
# alias gd='git diff'
alias gist="open http://gist.github.com"
# alias days="git log --since='2 month ago' --author=nkpart | grep Date | awk '{print \$2, \$3, \$4}' | uniq"
# alias my_work="git log --since='2 month ago' --date=short --author=nkpart --pretty=format:\"%ad\" | uniq"

# Apple 
alias qlp="qlmanage -p"
alias kf="killall Finder"
alias safari_curl='curl -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/534.57.2 (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2"'
alias blessed="sudo bless -setBoot -mount" # $ blessed /Volume/Foo

function dash() {
    open "dash://$*"
}

# Find a case insensitve string in the current hierarchy
function lookfor() {
  grep -EiIrl "$*" ./* | grep -v '.svn'
}

function psg() {
    PSOUT=`ps aux`; echo "$PSOUT" | grep -i "$1"
}

#python
# show help doc for symbol e.g. $ ph dict
function ph() {
    python -c "help($1)"
}

# Haskell
function h() {
  hoogle --color --count=30 ${1} 
}

# useful command to find what you should be aliasing:
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"


function to_ipod() {
   VAL="HandBrakeCLI -i ${1} -o ${1}.mp4 --preset=\"iPhone & iPod Touch\""
   echo $VAL
   sh -c $VAL
}

function install_py_version() {
    for v in $*; do
        CFLAGS="-I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include" LDFLAGS="-L$(brew --prefix openssl)/lib" pyenv install $v
    done
}

function jsoncurl() {
    curl $* | python -mjson.tool
}

function fill_file() {
  let A=1024*1024
	dd if=/dev/zero of=filefile${2}.filler bs=$A count=$1 seek=0
  echo creating file of size ${1}mb
}

# Project file goto
function go () {
	RES=$(find "$HOME/Projects/" "$HOME/Projects/oss" -maxdepth 1 -type dir -iname "${1}*" | head -n 1)
	if [[ "$RES" == "" ]]; then
		cd "$PROJECT_DIRS"
	else
		cd "$RES"
	fi
}

alias fo=go

function desym
{
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/PrivateFrameworks/DTDeviceKit.framework/Versions/Current/Resources/symbolicatecrash -A -v $1 . | more
}

export DEV_FOLDER=/Applications/Xcode.app/Contents/Developer

