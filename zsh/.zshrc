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
# export TERM="rxvt-unicode-256color"
export TERM="st-256color"

export BROWSER="/usr/bin/google-chrome-stable"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# Download powerlevel10k using: yay -S --noconfirm zsh-theme-powerlevel10k-git
# or set the theme here
ZSH_THEME="powerlevel10k/powerlevel10k"

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

#PATH=\$PATH:${HOME}/.gem/ruby/2.6.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/opt/nessus/bin:/opt/nessus/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:${HOME}/.local/bin/
PATH=\$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/opt/nessus/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:${HOME}/.local/bin/

# https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/#initial-setup
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# *info about all the plugins below
plugins=(
    fzf # ctrl+t / ctrl+r / ** <tab>
    sudo # esc key twice
    # fast-syntax-highlighting
    F-Sy-H
    copybuffer # ctrl+o
    #copydir
    #copyfile
    #dirhistory 
    zsh-autosuggestions # autosuggestions make zsh slower
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
# Fast-syntax-highlighing
#################################################
# https://github.com/zdharma/fast-syntax-highlighting
# run: git clone https://github.com/z-shell/F-Sy-H.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H

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
# run: git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6b7078,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(completion)

# install lf package
# Navigate throught directories using ctrl+f
# press enter on a directory to open it using a gui file manager
#lfcd () {
#    tmp="$(mktemp)"
#    lf -last-dir-path="$tmp" "$@"
#    if [ -f "$tmp" ]; then
#        dir="$(cat "$tmp")"
#        rm -f "$tmp"
#        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
#    fi
#}
#bindkey -s '^f' 'lfcd\n'

# Sourcing oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# VIM

#export EDITOR=/usr/bin/vim
#export VISUAL=/usr/bin/vim
VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR
#VISUAL=vim; export VISUAL EDITOR=vim; export EDITOR

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

source ~/.scripts/target
targetip=/tmp/targetip
if [[ -f $targetip ]]; then
  IP=$(cat $targetip)
fi

# Aliases
source ~/.zsh-aliases

export SUDO_ASKPASS=~/.scripts/rofi-askpass

##########################################################################
# Create and Extract files
##########################################################################

# create a *.tar.xz archive from a given file or directory
maketarxz() { tar cvJf "${1%%/}.tar.xz" "${1%%/}/" || return 1; }

# create a *.tar.gz archive from a given file or directory
maketargz() { tar cvzf "${1%%/}.tar.gz" "${1%%/}/" || return 1; }

# create a *.zip archive from a given file or directory
makezip() { zip -r "${1%%/}.zip" "$1" || return 1; }

# extract all files from an archive into current directory
ex() {
  local usage="Usage: extract <path/filename>.<zip|rar|bz2|deb|gz|tar|tbz2|tgz|Z|7z\
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
    folder=$(echo "$1" | cut -d'.' -f1)
    mkdir $folder
    cd $folder
    case "$1" in
      *.tar.bz2)  tar xvjf "../$1"    ;;
      *.tar.gz)   tar xvzf "../$1"    ;;
      *.tar.xz)   tar xvJf "../$1"    ;;
      *.lzma)     unlzma "../$1"      ;;
      *.bz2)      bunzip2 "../$1"     ;;
      *.rar)      unrar x -ad "../$1" ;;
      *.gz)       gunzip "../$1"      ;;
      *.tar)      tar xvf "../$1"     ;;
      *.tbz2)     tar xvjf "../$1"    ;;
      *.tgz)      tar xvzf "../$1"    ;;
      *.deb)      ar x "../$1"        ;;
      *.zip)      unzip "../$1"       ;;
      *.Z)        uncompress "../$1"  ;;
      *.7z)       7z x "../$1"        ;;
      *.xz)       unxz "../$1"        ;;
      *.exe)      cabextract "../$1"  ;;
      *)
        echo -e "Error: '$1' has no recognized extraction method.\n${usage}"
        rm $folder
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
#################################################################
# this can be commented out if using oh-my-zsh and ZSH_THEME is set to powerlevel10/powerlevel10k
#source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

#autoload -U compinit
#compinit

# only for oh-my-zsh
autoload -Uz compinit
if [[ $(whoami) == "root" ]]; then
    compinit -C 
else
    if [[ -n ${ZDOTDIR:-${HOME}}/$ZSH_COMPDUMP(#qN.mh+24) ]]; then
        compinit -d $ZSH_COMPDUMP
    else
        compinit -C
    fi
fi
# -D ........... disables .zcompudump file
# -d ........... used to set an alternative name to .zcompdump
# -i ........... accept insecure files
# -C ........... ignore checking at all

# Execute code in the background to not affect the current session
{
  # Compile zcompdump, if modified, to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

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
#clear
unsetopt PROMPT_SP

export PATH=$PATH:/home/desker/.spicetify
