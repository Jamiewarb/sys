#!/bin/bash
#  ~/.bashrc

#--------------------------#
# ALIASSES - APPLICATIONS  #
#--------------------------#
alias gst="git status --short --branch"
alias gpu="git push"
alias gpl="git pull"
alias gch="git checkout"
alias gco="git commit"
alias gad="git add"
alias grm="git rm"
alias gmv="git mv"
alias gbr="git branch"

alias subl=sublime

#--------------------------#
#  SHELL - LOOK AND FEEL   #
#--------------------------#
# Git branch for prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set prompt, colours and ls colours
export PS1="\[\033[35m\]\t\[\033[m\]:\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[32m\]\$(parse_git_branch)\[\033[m\]\n $ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Style ls output, colour, file type, file size changes
alias ls='ls -GFh'

echo 'Bash Shell loaded successfully - ~/.bashrc'
