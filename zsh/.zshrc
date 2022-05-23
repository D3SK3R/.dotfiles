clear
# clear at the start to prevent some 'artifacts' when quickly open terminal windows
###############################################################
#     ___         ___         ___          ___         ___
#    /\  \       /\  \       /\__\        /  /\       /  /\
#    \:\  \     /::\  \     /:/  /       /  /::\     /  /:/
#     \:\  \   /:/\ \  \   /:/__/       /  /:/\:\   /  /:/
#      \:\  \ _\:\~\ \  \ /::\  \ ___  /  /:/~/:/  /  /:/  ___
#_______\:\__\\ \:\ \ \__\:/\:\  /\__\/__/:/ /:/__/__/:/  /  /\
#\::::::::/__/:\ \:\ \/__//__\:\/:/  /\  \:\/:::::\  \:\ /  /:/
# \:\~~\~~    \:\ \:\__\      \::/  /  \  \::/~~~~ \  \:\  /:/
#  \:\  \      \:\/:/  /      /:/  /    \  \:\      \  \:\/:/
#   \:\__\      \::/  /      /:/  /      \  \:\      \  \::/
# ■  \/__/       \/__/       \/__/        \__\/       \__\/
###############################################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# SET ZSH AS DEFAULT SHELL
# chsh -s $(which zsh)
# and
# sudo chsh -s $(which zsh)
# or
# sudo chsh -s /bin/zsh

## DOWNGRADE

#The entries listed as "local" are versions from your local package cache. The entries identified as "remote" are available from the Arch Linux Archive(ALA).

#Warning: Installing packages from the ALA is inherently dangerous as sometimes Manjaro needs custom versions of certain packages. Doing this can result in a broken system. As a result, downgrading from the ALA is disabled by default on the stable branch. If needed, you can enable it by setting the environment variable
# just setting this variable like this isn't enough
DOWNGRADE_FROM_ALA=1
alias downgrade='sudo DOWNGRADE_FROM_ALA=1 downgrade'

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
#export TERM="xterm-256color"
export TERM="rxvt-unicode-256color"

export BROWSER="/usr/bin/google-chrome-stable"

autoload -U compinit
compinit

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
#ZSH_THEME="rounded"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
#HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

PATH=\$PATH:${HOME}/.gem/ruby/2.6.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/opt/nessus/bin:/opt/nessus/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:${HOME}/.local/bin/

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# *info about all the plugins below
plugins=(
    fzf # ctrl+t / ctrl+r / ** <tab>
    sudo # esc key twice
    fast-syntax-highlighting
    #copybuffer # ctrl+o
    #copydir
    #copyfile
    #dirhistory 
    # autosuggestions make zsh slower
    #zsh-autosuggestions
)

#################################################
# FZF
#################################################
# Set fzf installation directory path
export FZF_BASE=/usr/bin/fzf

export FZF_COMPLETION_OPTS='--height=60% --color=16'

# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

# Uncomment the following line to disable key bindings (CTRL-T, CTRL-R, ALT-C)
# export DISABLE_FZF_KEY_BINDINGS="true"

# To use FZF:
# https://www.tecmint.com/fzf-fuzzy-file-search-from-linux-terminal/
# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/fzf
# example: cat **<tab>
# ctrl+r to show command history
# ctrl-t to search for files

#################################################
# Fast-syntax-highlighing
#################################################
# To install fast-syntax-highlighting: (if not already on my .oh-my-zsh/ folder)
# https://github.com/zdharma/fast-syntax-highlighting
# copy all of this and run on a terminal (these 2 lines together):
# git clone https://github.com/zdharma/fast-syntax-highlighting.git \
#  ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting

#################################################
# Dirhistory
#################################################
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory
# alt + left	Go to previous directory
# alt + right	Undo alt + left
# alt + up	Move into the parent directory
# alt + down	Move into the first child directory by alphabetical order

#################################################
# copydir/copyfile/copybuffer
#################################################
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copydir
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copyfile
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copybuffer
#Copies the path of your current folder to the system clipboard.
#use the command copydir to copy the $PWD.
#
#Puts the contents of a file in your system clipboard so you can paste it anywhere.
#run the command copyfile <filename> to copy the file named filename.
#
#This plugin binds the "ctrl-o" keyboard shortcut to a command that copies the text that is currently typed in the command line ($BUFFER) to the system clipboard.
#This is useful if you type a command - and before you hit enter to execute it - want to copy it maybe so you can paste it into a script, gist or whatnot.

#################################################
# sudo
#################################################
#Easily prefix your current or previous commands with sudo by pressing esc twice

#################################################
# zsh-autosuggestions
#################################################
# https://github.com/zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6b7078,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# install lf package
# Navigate throught directories using ctrl+f
# press enter on a directory to open it using a gui file manager
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^f' 'lfcd\n'

# Sourcing oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# VIM

#export EDITOR=/usr/bin/vim
#export VISUAL=/usr/bin/vim
VISUAL=vim; export VISUAL EDITOR=vim; export EDITOR

# to vim
#bind -r '\C-s'
#stty -ixon

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# history
export HISTFILE=~/.history
HISTFILE=~/.history
HISTSIZE=10000                  #How many lines of history to keep in memory
SAVEHIST=10000                  #Number of history entries to save to disk
#HISTDUP=erase                  #Erase duplicates in the history file
setopt    appendhistory         #Append history to the history file (no overwriting)
setopt    sharehistory          #Share history across terminals
setopt    incappendhistory      #Immediately append to the history file, not just when a term is killed
setopt    INC_APPEND_HISTORY    #Immediately append to the history file, not just when a term is killed

# don't add garbage to history
function hist() {
    [[ "$#1" -lt 7 \
    || "$1" = "run-help "* \
    || "$1" = "cd "* \
    || "$1" = "man "* \
    || "$1" = "h "* \
    || "$1" = "~ "* ]]
    return $(( 1 - $? ))
}

# options
# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt correct
setopt interactive_comments

## Completition
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

# labels and categories on TAB completition
zstyle ':completion:*' group-name ''
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{green}->%F{yellow} %d%f'
zstyle ':completion:*:messages' format ' %F{green}->%F{purple} %d%f'
zstyle ':completion:*:descriptions' format ' %F{green}->%F{yellow} %d%f'
zstyle ':completion:*:warnings' format ' %F{green}->%F{red} no matches%f'
zstyle ':completion:*:corrections' format ' %F{green}->%F{green} %d: %e%f'

# command parameters
zstyle ':completion:*:functions' ignored-patterns '(prompt*|_*|*precmd*|*preexec*)'
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'
zstyle ':completion:*:(vim|nvim|vi|nano):*' ignored-patterns '*.(wav|mp3|flac|ogg|mp4|avi|mkv|iso|so|o|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|png|jpeg|jpg|gif)'
zstyle ':completion:*:(viewnior):*' ignored-patterns '*.(sh|docx|doc|wav|mp3|flac|ogg|mp4|avi|mkv|iso|so|o|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|)'
zstyle ':completion:*:(mpv):*' ignored-patterns '*.(sh|docx|doc|iso|so|o|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|$)'

# send the current terminal line to vim with ctrl-e:
#autoload edit-command-line; zle -N edit-command-line
#bindkey '^e' edit-command-line

## Keybindings section
## *EASIES WAY TO GET KEY CODES*
## open a terminal, press ctrl + v, it will show a ^, press the key and it will how like:
## ^[[3~ (this is for the insert key)
## and this is the code ZSH uses

## KEY CODES: https://www.zsh.org/mla/users/2014/msg00266.html
## COMMAND TO TEST KEY CODES: xxd
## AVAILABLE COMMANDS: http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#:~:text=The%20ZLE%20commands%20that%20key,modules%20(see%20Zsh%20Modules).

#bindkey -e
#bindkey '^[[H' beginning-of-line                                # Home key
#if [[ "${terminfo[khome]}" != "" ]]; then
#  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
#fi
#bindkey '^[[8~' end-of-line                                     # End key
#if [[ "${terminfo[kend]}" != "" ]]; then
#  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
#fi
#bindkey '^[[2~' overwrite-mode                                  # Insert key
#bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
#bindkey '^[[5~' history-beginning-search-backward               # Page up key
#bindkey '^[[6~' history-beginning-search-forward                # Page down key
#
## Navigate words with ctrl+arrow keys
#bindkey '^[Oc' forward-word                                     #
#bindkey '^[Od' backward-word                                    #

bindkey '^A' kill-whole-line                                    # delete the whole line with ctrl + a 

bindkey '^[[1;5D' backward-word                                 # backward word with ctrl right
bindkey '^[[1;5C' forward-word                                  # forward word with ctrl left

bindkey '^[[1;5A' end-of-line                                   # move to end of the line with ctrl up
bindkey '^[[1;5B' beginning-of-line                             # move to start of the line with ctrl down

bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[^?' kill-word                                        # delete forward word with alt+backspace
#bindkey '^[[Z' undo

# bind delete-char to delete key
bindkey '^[[3~' delete-char
# disables insert, end, home, page up and page down keys
bindkey -s '\e[2~' ''
bindkey -s '\e[8~' ''
bindkey -s '\e[7~' ''
bindkey -s '\e[6~' ''
bindkey -s '\e[5~' ''

#disables f8, f9, f10, f11 and f12 key
bindkey -s '\e[24~' ''
bindkey -s '\e[23~' ''
bindkey -s '\e[21~' ''
bindkey -s '\e[20~' ''
bindkey -s '\e[19~' ''
bindkey -s '\e[18~' ''
bindkey -s '\e[17~' ''
bindkey -s '\e[15~' ''

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r


###############################################################
#                         Functions                           #
###############################################################

###############################################################
#			          _ _                     				  #
#   		    /\   | (_)                    				  #
#			   /  \  | |_  __ _ ___  ___  ___ 				  #
#			  / /\ \ | | |/ _` / __|/ _ \/ __|				  #
#			 / ____ \| | | (_| \__ \  __/\__ \				  #
#			/_/    \_\_|_|\__,_|___/\___||___/				  #
###############################################################

#################################################################
#                     Basic terminal commands                   #
#################################################################
alias cd='f(){ cd "$@" ;ls;  unset -f f; }; f'
# alias ls='ls -CF --color=always'
# alias la='ls -lah'
alias ls='lsd --group-dirs first'
alias la='exa --group-directories-first --icons -lah'
alias cl='clear;ls'
alias rm='trash'
alias rmtrash='\rm -rf ~/.local/share/Trash/files/*'
alias trashcd='cd ~/.local/share/Trash/files/'
# confirm before mv or cp overwriting files
alias mv='mv -i'
alias cp='cp -ri'
alias ..='cd ..'
alias ...='cd ../..'
alias mkdir='mkdir -p'
alias cat='bat'
alias python='bpython'
#alias fzf="fzf | xargs -r -0 -i sh -c 'xdg-open \"{}\" &'"
#alias fzf="fzf --bind 'enter:execute(xdg-open {})'"
alias fzf="fzf --height=60% --color=16 | xargs xdg-open"
alias vim='stty stop "" -ixoff; vim'
alias v='stty stop "" -ixoff; vim'
alias c='clear'
alias cc='tput reset'
alias df='df -h'
alias grep='rg -i --color=always'
alias egrep='egrep -i --color=always'
# grep to show everything and just highlight the match:
alias grephl='rg --color=always -e "^" -e'
alias open='xdg'
alias mount='sudo mount'
alias umount='sudo umount'
alias fd='fd -H'
#alias cn='tput reset;neofetch | lolcat -a -s 1000000'
alias cn='clear;neofetch'
# host text on a pastebin web
alias bin='nc termbin.com 9999'
alias gotop='gotop -aps'
#alias pip='sudo pip'
alias clock='tty-clock -cb'
alias floating='urxvt -name floating_terminal &'
alias floating2='urxvt -name floating_terminal2 &'
#alias floating='urxvt -name floating_urxvt &'
#alias floating2='urxvt -name dropdown_urxvt &'
alias player='urxvt -title ncmpcpp -e ncmpcpp &'
alias kill='kill -9'
alias todo='calcurse;clear'
alias cal='cal -y'
alias myip='curl ipinfo.io/ip'
alias myipv6="ip addr show dev wlan0 | sed -e's/^.*inet6 \([^ ]*\)\/.*$/\1/;t;d' | head -n1"
alias wget='wget --no-check-certificate'
alias ch='chmod +x'
alias boot='systemd-analyze'
#alias hosts='sudo vim /etc/hosts'
alias resetaudio='systemctl --user restart pulseaudio'
alias xdg='xdg-open'
alias disk='lsblk'
alias du='dust'
alias size='"du" -sh *'
alias rpolybar='sh ~/.config/polybar/launch.sh'
alias stow='cd ~/.dotfiles;stow -vt ~'
# stow: https://www.youtube.com/watch?v=CFzEuBGPPPg
#alias dotfiles='cd ~/.dotfiles/;git add .;git commit -m "default commit";git push;cd ~;clear'
alias dots='sh ~/.scripts/dotfiles.sh'
alias mousepos='eval $(xdotool getmouselocation --shell);echo "$X""x""$Y"'
alias font-update='sudo fc-cache -fv'
alias font-list='fc-list'
alias psa='ps auxf'
alias pscpu='ps -eo user,pid,pcpu,pmem,comm --sort -pcpu | head'
alias psram='ps -eo user,pid,pcpu,pmem,comm --sort -pmem | head'
alias free='free -mt'
alias info='inxi -Fxz'
alias ports='sudo netstat -tnlp'
alias xresources='vim ~/.dotfiles/xresources/.Xresources;"cp" ~/.dotfiles/xresources/.Xresources ~/.Xresources'
alias clip='clipster -c'
alias copy='clipster -c'
alias memmonitor="while true; do c;echo '*/proc/swaps';cat /proc/swaps;echo '\n*free -m';free;echo '\n*swapon -s';swapon -s;echo '\n*zramctl'; zramctl;sleep 0.2;done"
alias keydetect="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias ip="ip -c"
alias keys="sh .scripts/showKeys.sh"

#################################################################
# Pacman 
#################################################################
#alias install='sudo pacman -S'
alias install='~/.scripts/install'
alias search='~/.scripts/searchPacman'
alias packages='pacman -Q'
alias lastpacman='\grep -E "upgraded|installed" /var/log/pacman.log'
# only works on manjaro, for arch, use something like reflector-simple
alias update-mirrors='sudo pacman-mirrors -id'
# for arch:
#alias updatemirrors='sudo reflector --verbose --latest 50 --protocol https \
#  --sort rate --save /etc/pacman.d/mirrorlist && yay'
alias yay='f(){ yay "$@" --noconfirm --sudoloop;  unset -f f; }; f'
alias update='yay -Syyu --sudoloop'
alias update-manual='"yay" -Syyu --sudoloop'
alias update-noCheck='yay -Syyu --mflags --skipinteg --sudoloop'
alias tri='f(){ trizen "$@" --noconfirm;  unset -f f; }; f'
#alias update='trizen -Syyu --noconfirm'
#alias update-manual='trizen -Syyu'
#alias update-noCheck='trizen -Syyu --noconfirm --skipinteg'
alias patchnotes='$BROWSER https://forum.manjaro.org/c/announcements/stable-updates & sleep 1;c'
alias remove='sudo pacman -Rns'
alias remove-force='sudo pacman -Rnsdd'
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias cleanup='sh ~/.scripts/cleanup.sh'

#################################################################
# zsh related
#################################################################
alias zshrc='stty stop "" -ixoff; vim ~/.zshrc;"cp" ~/.zshrc ~/MEGA/D3SK3R/D3SK3R/Linux/1_FirstSteps/6_zsh/dots/.zshrc'
alias rzsh='source ~/.zshrc && source ~/.p10k.zsh' # reload terminal configs
alias vundle='vim +PluginInstall +qall'

#################################################################
# pentest related
#################################################################
alias pwncat-env='source /opt/pwncat/pwncat-env/bin/activate'
alias airgeddon='sudo airgeddon'
alias evillimiter='sudo evillimiter'
alias arpspoof='sudo arpspoof'
alias wifiphisher='sudo wifiphisher'
alias wifite='sudo wifite2'
# wlp3s0 or wlan0
alias monitoron='sudo airmon-ng start wlan0'
alias monitoroff='sudo airmon-ng stop wlan0mon'
# Full Network restart, useful when using airodump
alias netrestart='sudo iw wlan0 del;sudo airmon-ng stop wlan0mon'
#alias phonesploit='python2 /home/d3sk3r/MEGA/D3SK3R/D3SK3R/pentest/AndroidExploitation/PhoneSploit/main_linux.py'
alias setoolkit='sudo setoolkit'
alias msf='sudo msfconsole'
alias kickthemoff='sudo python MEGA/D3SK3R/D3SK3R/pentest/kickthemout/kickthemout.py'
# Shorten URL using the following services: bit.ly, j.mp, t.cn, is.gd, v.gd, tiny.cc.
alias blackeye='sudo ~/MEGA/D3SK3R/D3SK3R/pentest/Phishing/blackeye/blackeye.sh'
alias ciphey='sudo docker run -it --rm remnux/ciphey'

#################################################################
# WEB/IP related
#################################################################
alias server='python -m  http.server 1337'
#alias httpdon='sudo systemctl enable httpd'
#alias httpdoff='sudo systemctl disable httpd'
alias ngrok='~/MEGA/D3SK3R/D3SK3R/ngrok/ngrok'
alias pktriot='~/MEGA/D3SK3R/D3SK3R/pktriot-0.9.18/pktriot'
alias remote_ssh='ssh -R d3sk3r:22:localhost:22 serveo.net'
# To connect to the remote_ssh: ssh -J serveo.net d3sk3r@d3sk3r

#################################################################
# ADB related
#################################################################
alias adb_list='adb shell pm list packages'
alias adb_run='f(){ adb shell monkey -p "$@" -c android.intent.category.LAUNCHER 1;  unset -f f; }; f'
alias adb_vol='f(){ adb shell media volume --show --stream "$1" --set "$2";  unset -f f; }; f'
alias adb_getVol='for n in {1..14}; do adb shell media volume --stream $n --get;printf "\n";done'
alias adb_cam='adb shell am start -a android.media.action.IMAGE_CAPTURE --ei android.intent.extras.CAMERA_FACING 1;clear'
alias adb_sound='adb shell am start -a android.intent.action.VIEW -d "file:///sdcard/\ .mp3" -t audio/mp3;sleep 0.5;adbe press back'
alias adb_getBright='adb shell settings get system screen_brightness'
alias adb_bright='adb shell settings put system screen_brightness' # brightness from 0 to 255
#alias adb_toggle='~/.scripts/adb_toggle.sh '
#alias adb_layout='while true; do adbe layout on;sleep 1;adbe layout off;done'
#alias adb_rotate='while true; do adbe rotate landscape;sleep 2;adbe rotate portrait;sleep 2;done'
alias autoadb='sh ~/.scripts/auto_adb.sh'

#################################################################
# random aliases
#################################################################

alias pt='f(){ trans -b -t portuguese "$@" | lolcat;  unset -f f; }; f'
alias en='f(){ trans -b "$@" | lolcat;  unset -f f; }; f'
#alias cava='cava | lolcat -p 100000'
# lolcat bugged
#alias pipes='pipes.sh -t3 | lolcat'
alias pipes='pipes.sh -t3'
#alias say='fortune | cowsay -f turtle | lolcat -a -s 1000'
#alias powersave='sudo /home/d3sk3r/MEGA/D3SK3R/D3SK3R/Linux/CPUFrequency/powersave.sh'
#alias performance='sudo /home/d3sk3r/MEGA/D3SK3R/D3SK3R/Linux/CPUFrequency/performance.sh'
alias cpu='lscpu | grep MHz | lolcat;sensors | grep Core | lolcat'
alias hh='hollywood;kill $(ps ax | grep -e "tmux" -e "hollywood" | head -n1 | cut -d" " -f1);killall ccze'
alias hq='kill $(ps ax | grep -e "tmux" -e "hollywood" | head -n1 | cut -d" " -f1);killall ccze'
alias emoji='rofimoji --action copy'
alias short='shortn'
alias notify='dunstify Finished;mpg123 -q ~/.scripts/ding-notif.mp3' 
alias colors-list='for i in {0..255}; do; printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n";done'
alias tmux-layout='tmux select-layout "2e4b,190x47,0,0{95x47,0,0,0,94x47,96,0[94x23,96,0,1,94x23,96,24,2]}"'
alias color-test='msgcat --color=test'
alias colors='curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash'
alias loopbackmic='arecord -f cd - | aplay -'
alias urandom='{ while true; do head -c 16 /dev/urandom | xxd; sleep 0.2; done; }'

alias webp2jpg='magick mogrify -format jpg *.webp;rm *.webp'

alias fakecam='f(){ ffmpeg -stream_loop -1 -re -i $@ -vcodec rawvideo -threads 0 -f v4l2 /dev/video0;  unset -f f; }; f'
alias webcam-disable='sudo modprobe -r uvcvideo'
alias webcam-enable='sudo modprobe uvcvideo'

alias vps='ssh -i ~/.ssh/id_rsa ubuntu@144.22.163.237'

# simple alternative:
#alias crypto='f(){ forx $@ brl;  unset -f f; }; f'
alias crypto='export ALPHAVANTAGE_API_KEY=7YHWWPANUG42KXZS;tstock -c brl'

alias ahegao='clear;echo "⠄⠄⠄⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄⠄⠄⠄⡀⠄⢀⣿⣿⠄⠄⠄⢸⡇⠄⠄
 ⠄⠄⠄⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄
⠄⠄⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄
⠄⠄⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄
⠄⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰
⠄⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤
⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗
⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄
⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠄
⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃⠄
⠄⠘⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃⠄⠄
⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁⠄⠄⠄
⠄⠄⠄⠄⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁⠄⠄⠄⠄⠄
⠄⠄⠄⠄⠄⠄⠄⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁⠄⠄⠄⠄⠄⢀⣠⣴
⣿⣿⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⣠⣴⣿⣿⣿" | lolcat'

alias ahegaorgb='while true; do clear; ahegao | lolcat -a -s 300;done'

##########################################################################
# Create and Extract files
##########################################################################

# create a *.tar.xz archive from a given file or directory
maketarxz() { tar cvJf "${1%%/}.tar.xz" "${1%%/}/" || return 1; }

# create a *.tar.gz archive from a given file or directory
maketargz() { tar cvzf "${1%%/}.tar.gz" "${1%%/}/" || return 1; }

# create a *.zip archive from a given file or directory
makezip() { zip -r "${1%%/}.zip" "$1" || return 1; }

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# extract all files from an archive into current directory
extract() {
  local usage="Usage: extract <path/filename>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z\
|xz|ex|tar.bz2|tar.gz|tar.xz>"
  if [[ -z "$1" ]]; then
    echo "${usage}"
    return 1
  elif [[ ! -f "$1" ]]; then
    if [[ -d "$1" ]]; then
      echo -e "Error: '$1' is a directory.\n${usage}"
    else
      echo -e "Error: '$1' does not exist.\n${usage}"
    fi
    return 1
  else
    case "$1" in
      *.tar.bz2)  tar xvjf "$1"    ;;
      *.tar.gz)   tar xvzf "$1"    ;;
      *.tar.xz)   tar xvJf "$1"    ;;
      *.lzma)     unlzma "$1"      ;;
      *.bz2)      bunzip2 "$1"     ;;
      *.rar)      unrar x -ad "$1" ;;
      *.gz)       gunzip "$1"      ;;
      *.tar)      tar xvf "$1"     ;;
      *.tbz2)     tar xvjf "$1"    ;;
      *.tgz)      tar xvzf "$1"    ;;
      *.zip)      unzip "$1"       ;;
      *.Z)        uncompress "$1"  ;;
      *.7z)       7z x "$1"        ;;
      *.xz)       unxz "$1"        ;;
      *.exe)      cabextract "$1"  ;;
      *)
        echo -e "Error: '$1' has no recognized extraction method.\n${usage}"
        return 1
        ;;
    esac
  fi
}

# create a directory and cd into it
#mcd() {
mkd() {
  if [[ -z "$1" ]]; then
    echo "Usage: mkd <new_dir>"
    return 1
  else
    mkdir "$1" || return 1
    cd "$1" || return 1
  fi
}

#################################################################
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

source $HOME/.scripts/dkill.sh
#source $HOME/.scripts/dotfiles.sh
# ____             _          _____ _          _ _
#|  _ \           (_)        / ____| |        | | |
#| |_) | ___  __ _ _ _ __   | (___ | |__   ___| | |
#|  _ < / _ \/ _` | | '_ \   \___ \| '_ \ / _ \ | |
#| |_) |  __/ (_| | | | | |  ____) | | | |  __/ | |
#|____/ \___|\__, |_|_| |_| |_____/|_| |_|\___|_|_|
#             __/ |
#            |___/

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# these 2 lines prevent the % when fast opening terminals
clear
unsetopt PROMPT_SP
