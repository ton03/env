## General
alias ls="ls -GFh"
alias ll="ls -l"
alias lal="ls -al"

## Directories
alias cdw="cd ~/Work"
alias cdp="cd ~/Play"

## Git
alias gits="git status"
alias gitb="git branch"
alias gitcm="git commit"
alias gitcma="git commit -a"
alias gitcmam="git commit -a -m"
alias gitcmaa="git commit -a --amend"
alias gitcmaam="git commit -a --amend -m"
alias gitco="git checkout"
alias gitcom="git checkout main"
alias gitcob="git checkout --track origin/main -b"
alias gitd="git diff"
alias gitpr="git pull -r"
alias gitprom="git pull -r origin main"
alias gitl="git log --graph --abbrev-commit --pretty=oneline --decorate"
alias gitk="(which gitk &> /dev/null && gitk) || gitl"

## Yarn
alias y="yarn"
alias ys="yarn start"
alias yb="yarn build"
alias yt="yarn test"

