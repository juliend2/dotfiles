source /c/Users/Julien/bin/dotfiles/bash_aliases.sh

export PATH="$PATH:$HOME/bin:$HOME/bin/php:$HOME/AppData/Local/bin/NASM"

export PATH="$PATH:$HOME/bin/dotfiles"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"

# Start ssh-agent:
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi
# Add keys:
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/id_ed25519

