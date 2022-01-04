alias g='git'

JVIMRC=$HOME/.jvimrc
if test -f "$JVIMRC"; then
  alias jim="vim -u $JVIMRC"
else
  alias jim="echo '\`jim\` command is not set because there is no $JVIMRC file.'"
fi
