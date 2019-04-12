## General
alias ls="ls -GFh"
alias ll="ls -l"
alias lal="ls -al"

## Directories
alias cdiw="cd /cygdrive/c/Work"

## Git
alias gits="git status"
alias gitb="git branch"
alias gitcm="git commit"
alias gitcma="git commit -a"
alias gitcmam="git commit -a -m"
alias gitcmaa="git commit -a --amend"
alias gitcmaam="git commit -a --amend -m"
alias gitco="git checkout"
alias gitcom="git checkout master"
alias gitcob="git checkout --track origin/master -b"
alias gitd="git diff"
alias gitpr="git pull -r"
alias gitprom="git pull -r origin master"
alias gitrd="git review --download"
alias gitrf="git review --finish"
alias gitl="git log --graph --abbrev-commit --pretty=oneline --decorate"
alias gitk="(which gitk &> /dev/null && gitk) || gitl"
