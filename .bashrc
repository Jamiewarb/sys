#!/bin/bash
#  ~/.bashrc
#

#--------------------------#
# ALIASSES - APPLICATIONS  #
#--------------------------#
#//------- Shell --------\\#
alias mkdir="mkdir -pv"
alias wget="wget -c"
alias histg="history | grep"

#//----- Git & Hub ------\\#
alias git="hub"
alias gst="git status --short --branch"
alias gpu="git push"
alias gpl="git pull"
alias gch="git checkout"
alias gco="git commit"
alias gad="git add"
alias grm="git rm"
alias gmv="git mv"
alias gbr="git branch"

#//------- Hex ----------\\#
alias cdwp='cd wp-content/themes/$(basename "$PWD")'
alias cdbill='cd ~/Sites/bills/wp-content/themes/billstheme'

alias cdq=gotorepo

alias subl=sublime

#--------------------------#
#  SHELL - LOOK AND FEEL   #
#--------------------------#
#  # Git branch for prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set prompt, colours and ls colours
export PS1="\[\033[35m\]\t\[\033[m\]:\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[32m\]\$(parse_git_branch)\[\033[m\]\n $ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Style ls output, colour, file type, file size changes
alias ls='ls -GFh'
alias ll='ls -lah'

export PATH="/usr/local/sbin:$PATH"

#--------------------------#
#    SHELL - FUNCTIONS     #
#--------------------------#

# create dir and move in to it
function mcd() {
    mkdir "$@" && cd "$@"
}

# Change working directory to a wordpress repo
function gotorepo() {
    cd ~/Sites/$1 && cdwp
}

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

# extract almost any time of archive file
function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    else
        if [ -f $1 ] ; then
            # NAME=${1%.*}
            # mkdir $NAME && cd $NAME
            case $1 in
              *.tar.bz2)   tar xvjf ../$1    ;;
              *.tar.gz)    tar xvzf ../$1    ;;
              *.tar.xz)    tar xvJf ../$1    ;;
              *.lzma)      unlzma ../$1      ;;
              *.bz2)       bunzip2 ../$1     ;;
              *.rar)       unrar x -ad ../$1 ;;
              *.gz)        gunzip ../$1      ;;
              *.tar)       tar xvf ../$1     ;;
              *.tbz2)      tar xvjf ../$1    ;;
              *.tgz)       tar xvzf ../$1    ;;
              *.zip)       unzip ../$1       ;;
              *.Z)         uncompress ../$1  ;;
              *.7z)        7z x ../$1        ;;
              *.xz)        unxz ../$1        ;;
              *.exe)       cabextract ../$1  ;;
              *)           echo "extract: '$1' - unknown archive method" ;;
            esac
        else
            echo "$1 - file does not exist"
        fi
    fi
}

# git functions
function newb() {
    read -p "Branch '$1' from$(parse_git_branch) and push to remote (y/n)? " answer;
    case ${answer:0:3} in
        y|Y|yes|Yes|YES|oui|Oui|OUI|si|Si|SI )
            git checkout -b $1 && git push -u origin $1;
        ;;
        * )
            echo 'Branch was not created'
        ;;
    esac
}

complete -C aws_completer aws

echo 'Bash Shell loaded successfully - ~/.bashrc'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
