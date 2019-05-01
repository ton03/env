DIR=`dirname ${BASH_SOURCE[0]}`

## Ton's environment
source "${DIR}/aliases.sh"
source "${DIR}/functions.sh"

## Wow much colors
export PS1="\[\033[33;1m\]\w\[\033[m\] \[\033[32m\]\$(parse_git_branch)\[\033[m\]\n\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
