#  ---------------------------------------------------------------------------
#
#  WOW, I MADE A BASH PROFILE
#
#  ---------------------------------------------------------------------------
#
#  Ultra
#
#  ----------------------------------------------------------------------------
#  Daily tools
#  ----------------------------------------------------------------------------

# math
= () {
    bc -l <<< "$@"
}

# show alias: to remind yourself of an alias (given some part of it)
showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

#clear terminal
alias clear="clear && printf '\e[3J'"

# easy show invisible files
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# DNS Flush
alias flush="sudo killall -HUP mDNSResponder"

# generate quick spook lorem for passwords. REQUIRES brew install lorem
alias spook="lorem --spook --randomize"

# disable gamed
alias gamed="launchctl unload /System/Library/LaunchAgents/com.apple.gamed.plist"

# mute the system volume
alias stfu="osascript -e 'set volume output muted true' && echo 'muted!'"

# clip working directory path
alias clipPath='pwd|tr -d "\n"|pbcopy'

# easy quit app
function quitter(){
 # echo "Enter App Name: "
	read -e -p "Enter Application Name: " inputpath
	osascript -e 'quit app "'$inputpath'"'
}



# Git
# ----------------------------------------------------------------------------

# Remove git from a project
alias ungit="find . -name '.git' -exec rm -rf {} \;"

# Clear cache
alias regit="git rm -r --cached ."

# Add
alias add="git add ."
alias commit="git commit -m"
alias push="git push origin master"
alias pull="git pull"

# Fetch and Force Overwrite
alias gitforcefetch="git fetch --all && git reset --hard origin/master"

# Set new remote origin
alias gitremote="git remote add origin"

# Add submodules
alias gitsub="git submodule add"
alias gitsubup="git submodule update --recursive --remote"


# Dev
# ----------------------------------------------------------------------------

# Add gulp to autocompletion
#eval "$(gulp --completion=bash)"

# CD && ATOM && GULP
#function atomicgulp(){
#  # echo "Enter Directory: "
#	read -e -p "Enter Project Directory: " inputpath
#	# echo "Enter gulp command: "
#  # read -p "Enter gulp command: gulp + " gulpcmd
#	cd "$inputpath" && atom . && gulp
#}

# scrub exif data from an image
alias scrub="exiftool -all="

# generate a self-signed ssl cert
sslkeygen(){
	read -e -p "Enter Name of Cert to Generate: " certname
	echo "Generating '$certname'"
	openssl req -x509 -sha256 -newkey rsa:2048 -keyout $certname.key -out $certname.crt -days 1024 -nodes
}

# httpDebug:  Download a web page and show info on what took time
speedtest () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

#httpTools
alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#find all html files in directory
htmlhunter () {
        find . -iname '*.html' | while read line; do
                echo "Finding HTML and opening $line"
#               open "$line"
        done
}

#  ----------------------------------------------------------------------------
#
#  Elite
#
#  ----------------------------------------------------------------------------

# change hostname
alias changeHostname="sudo scutil --set HostName"

# Get public IP from openDNS
alias watismyip="echo 'the internet sees you RIGHT NOW as:' && dig +short myip.opendns.com @resolver1.opendns.com"

#easy nmap
alias scan="sudo nmap -sV -Pn -p- -T4"
alias portcheck="sudo lsof -i"
alias kextcheck="sudo ls -al /var/db/dslocal/nodes/Default/users && kextstat -l | grep -v com.apple"
alias usercheck="dscl . list /Users"
alias userinfo="dscacheutil -q user"

# networking tools
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ;watismyip
    #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    echo
}



# ----------------------------------------------------------------------------
#
# Environmentals
#
# ----------------------------------------------------------------------------

#   Change Prompt
#   ------------------------------------------------------------
export PS1="________________________________________________________________________________\n| \w @ \h (\u) \n| => "
export PS2="| => "

#   Change Prompt Color for Various Servers (the tmux effect)
#   ------------------------------------------------------------

# Green
#export PS1="\[\033[01;32m\]________________________________________________________________________________\n| \w @ \h (\u) \n| => \[\033[00m\]"
#export PS2="\[\033[01;32m\]| => \[\033[00m\]"

# Cyan
#export PS1="\[\033[01;36m\]________________________________________________________________________________\n| \w @ \h (\u) \n| => \[\033[00m\]"
#export PS2="\[\033[01;36m\]| => \[\033[00m\]"

# Blue
#export PS1="\[\033[01;34m\]________________________________________________________________________________\n| \w @ \h (\u) \n| => \[\033[00m\]"
#export PS2="\[\033[01;34m\]| => \[\033[00m\]"




#   Set Default Editor (change 'Nano' to the editor of your choice)
#   ------------------------------------------------------------
export EDITOR=/usr/bin/nano

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
export BLOCKSIZE=1k

#   Add color to terminal
#   (this is all commented out as I use Mac Terminal Profiles)
#   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#   ------------------------------------------------------------
#   export CLICOLOR=1
#   export LSCOLORS=ExFxBxDxCxegedabagacad


#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias edit='subl'                           # edit:         Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
mans () {
    man $1 | grep -iC2 --color=always $2 | less
}

#   cdf:  'Cd's to frontmost window of MacOS Finder
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

#   extract:  Extract most know archives with one command
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}





#   ---------------------------
#   4.  SEARCHING
#   ---------------------------

alias quickfind="find . -iname "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

#   ---------------------------
#   5. PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }

#   Memory checker
# Top
alias topcpu='top -o cpu'
alias topmem='top -o rsize' # memory
alias topten="top -R -F -s 10 -o rsize"

# List Hardware Interfaces
alias hwcheck='networksetup -listallhardwareports'

# Remaining Battery Time (OS X)
#alas battTime="pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f3 -d';'"

# Remaining Battery Percent (OS X)
#alias battPercentage="pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';'"


#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'
