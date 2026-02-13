# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Env
source $HOME/.zshenv

# Dev
eval "$(rbenv init - zsh)"
eval "$(nodenv init -)"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
export TERM_THEME="green"
ZSH_THEME="local"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ----------------------------------------------------------------------------
# Environmentals & Colors
# ----------------------------------------------------------------------------
HISTSIZE=25000
SAVEHIST=25000
HISTFILE=~/.zsh_history

# Standard Color Vars (for scripts/echo)
RED=$'\033[01;31m'
YEL=$'\033[01;33m'
GREEN=$'\033[01;32m'
BLUE=$'\033[01;34m'
PURP=$'\033[00;35m'
CY=$'\033[01;36m'
MAG=$'\033[01;35m'
WHITE=$'\033[00;01m'
NC=$'\033[00m'

# Prompt-Specific Color Vars (Zsh Native)
REDF="%B%F{red}"
YELF="%B%F{yellow}"
GREENF="%B%F{green}"
BLUEF="%B%F{blue}"
PURPF="%F{magenta}"
CYF="%B%F{cyan}"
MAGF="%B%F{magenta}"
WHITEF="%B%F{white}"
NCF="%b%f"

export EDITOR=/usr/bin/nano
export BLOCKSIZE=1k

# ----------------------------------------------------------------------------
# The "Architect" Prompt & Line Logic
# ----------------------------------------------------------------------------
# Lockdown Mode
lockdown() {
  PROMPT='${GREENF}| %b%f%~ ${WHITEF}@host ${GREENF}(${NCF}${REDF}user${NCF}${GREENF}) 
${GREENF}| => ${NCF}'
}

# ----------------------------------------------------------------------------
# Git Aliases
# ----------------------------------------------------------------------------
alias ungit="find . -name '.git' -exec rm -rf {} \;"
alias regit="git rm -r --cached ."
alias add="git add ."
alias commit="git commit -m"
alias push="git push origin master"
alias pull="git pull"
alias gitforcefetch="git fetch --all && git reset --hard origin/master"
alias gitremote="git remote add origin"
alias gitsub="git submodule add"
alias gitsubup="git submodule update --recursive --remote"

updaterepos() {
    local CUR_DIR=$(pwd)
    print -P "\n%B%UPulling in latest changes for all repositories...%u%b\n"
    for i in $(find . -name ".git" | cut -c 3-); do
        print -P "\n${YELF}+$i${NCF}"
        cd "${i:h}" # Move to parent of .git
        git pull origin master
        cd "$CUR_DIR"
    done
    print -P "\n${GREENF}Complete!${NCF}\n"
}

# ----------------------------------------------------------------------------
# Security & System
# ----------------------------------------------------------------------------
alias gamed="launchctl unload /System/Library/LaunchAgents/com.apple.gamed.plist"
alias scrub="exiftool -all="
alias metacheck="mdls"
alias metadeep="xattr"
alias metachange="SetFile"
alias datechanger="SetFile -d '8/4/2001 16:13'"
alias changeHostname="sudo scutil --set HostName"

maclist() {
    for x in $(ifconfig -l); do 
        echo -n "${YEL}$x:${NC}" && macchanger -s $x 2>/dev/null || echo " N/A"
    done
}

iplist() {
    ifconfig -u | awk '$1 == "inet" { print "'${YEL}'" $2 "'${NC}'" }' | sed 's/://g'
}

alias ipcheck0='ipconfig getpacket en0'
alias ipcheck1='ipconfig getpacket en1'
alias portscan="sudo nmap -sV -Pn -p- -T4"
alias census="sudo nmap -F"
alias arpy="arp -a -n"
alias netcheck="sudo lsof -i"

portcheck() {
    netcheck | awk '$8 == "TCP" {print "'${YEL}'" $1 "'${NC}'","'${BLUE}'" $3 "'${NC}'","'${YEL}'" $9 "'${NC}'"}'
}

# Auditing & Monitoring
alias daemoncheck="sudo launchctl list | grep -v com.apple"
alias usercheck="dscl . list /Users"
userlist() {
    sudo ls -al /var/db/dslocal/nodes/Default/users | grep -v com.apple | awk '{ print "'${YEL}'" $3 "'${NC}'" "'${BLUE}'" $5 "'${NC}'" "'${YEL}'" $9 "'${NC}'" }'
}

processcheck() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,command }
findprocess() { lsof -t -c "$@" ; }
alias watismyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias flush="sudo killall -HUP mDNSResponder && dscacheutil -flushcache"

# ----------------------------------------------------------------------------
# Dev Tools
# ----------------------------------------------------------------------------
alias dockerstopall='docker stop $(docker ps -aq)'
alias dockerrmall='docker rm $(docker ps -aq)'

function sslkeygen() {
    vared -p "Enter Name of Cert: " -c certname
    openssl req -x509 -sha256 -newkey rsa:2048 -keyout $certname.key -out $certname.crt -days 1024 -nodes
}

function showfiles(){
  defaults write com.apple.finder AppleShowAllFiles -bool YES
  killall Finder
}

function hidefiles(){
  defaults write com.apple.finder AppleShowAllFiles -bool NO
  killall Finder
}

cdf () {
    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Finder"
            try
        set currFolder to (folder of the front window as alias)
            on error
        set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

# ----------------------------------------------------------------------------
# Navigation & Terminal Improvements
# ----------------------------------------------------------------------------
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ll='ls -FGlAhp'
alias less='less -FSRXc'
alias ..='cd ../'
alias ...='cd ../../'
alias edit='subl'
alias f='open -a Finder ./'
alias c='clear'
alias path='echo $PATH | tr ":" "\n"'
alias clear="clear && printf '\e[3J'"
mcd() { mkdir -p "$1" && cd "$1" }
trash() { command mv "$@" ~/.Trash }
ql() { qlmanage -p "$@" >& /dev/null }

# Auto-ls on cd
cd() { builtin cd "$@"; ll; }

# pwdz for Zsh
pwdz() {
    pgrep zsh | xargs -I {} lsof -a -p {} -d cwd -Fn 2>/dev/null | \
    sed -n 's/^n//p' | \
    while read -r line; do
        printf "${YEL}%s${NC}\n" "$line"
    done
}

# 1. Internal helper to get clean, unique paths
_get_raw_zsh_paths() {
    pgrep zsh | xargs -I {} lsof -a -p {} -d cwd -Fn 2>/dev/null | \
    sed -n 's/^n//p' | sort -u
}

cdd() {
    # Local color definitions
    local YEL=$'\e[1;33m'
    local NC=$'\e[0m'

    # Populate the RAW data array
    local -a paths
    paths=("${(@f)$(_get_raw_zsh_paths)}")

    if [[ ${#paths} -eq 0 ]]; then
        echo "No active zsh directories found."
        return 1
    fi

    # Create a DISPLAY array with colors
    local -a display_paths
    for p in "${paths[@]}"; do
        display_paths+=("${YEL}${p}${NC}")
    done

    echo "Select a directory to cd into:"

    # We run 'select' on the colored display array
    select opt in "${display_paths[@]}"; do
        if [[ -n "$opt" ]]; then
            # 'REPLY' is a built-in variable that holds the index number chosen
            # We use that index to grab the clean path from our raw 'paths' array
            local target_path="${paths[$REPLY]}"
            
            cd "$target_path" && break
        else
            echo "Invalid selection. Please choose a number from the list."
        fi
    done
}
# Quick Search
ff() { /usr/bin/find . -name "$@" ; }
alias markdown='mdv'

# ----------------------------------------------------------------------------
# OS X Specifics
# ----------------------------------------------------------------------------
alias stfu="osascript -e 'set volume output muted true'"
function quitter() {
    vared -p "Enter App Name: " -c appname
    osascript -e "quit app \"$appname\""
}

# ----------------------------------------------------------------------------
# Initialize Session
# ----------------------------------------------------------------------------
ii() {
    print -P "\n${REDF}Internals:${NCF}"
    uname -a
    print -P "\n${YELF}%n${NCF} logged on to ${YELF}%m${NCF}"
    print -P "\n${REDF}Users logged on:${NCF}"
    w -h
    print -P "\n${REDF}Machine stats:${NCF}"
    uptime
    print -P "\n${REDF}Current date:${NCF}"
    echo -e "${YEL}$(date)${NC}"
    print -P "\n${REDF}Current Working Dirs:${NCF}"
    pwdz
    print -P "\n${REDF}IP Addresses:${NCF}"
    iplist
    print ""
}

# Run it
ii