## Ton's environment
scriptdir=`dirname "$BASH_SOURCE"`
source "${scriptdir}/aliases.sh"
source "${scriptdir}/functions.sh"

## Pretty colors
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
