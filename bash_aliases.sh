alias g='git'
alias m='make'
alias ll='ls -la'
alias zed='zeditor'

JVIMRC=$HOME/.jvimrc
if test -f "$JVIMRC"; then
  alias jim="vim -u $JVIMRC"
else
  alias jim="echo '\`jim\` command is not set because there is no $JVIMRC file.'"
fi

alias agent='eval "$(ssh-agent -s)"'
