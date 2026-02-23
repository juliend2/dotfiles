source $HOME/bin/dotfiles/bash_aliases.sh

export PATH="$PATH:$HOME/bin:$HOME/bin/php:$HOME/AppData/Local/bin/NASM"

export PATH="$PATH:$HOME/bin/dotfiles"
export PATH="$PATH:/var/lib/snapd/snap/bin"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"


# COLORS IN TERMINAL
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# BRANCH NAME AND TIME IN COMMAND PROMPT
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$color_prompt" = yes ]; then
  PS1='\t ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]$(parse_git_branch)\[\033[00m\]\n\$ '
else
  PS1='\t ${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\n\$ '
fi
unset color_prompt force_color_prompt

# SSH

# Path to store ssh-agent environment variables
export SSH_ENV="$HOME/.ssh/agent-environment"

# Start ssh-agent if needed
function start_agent {
    echo "Initializing new SSH agent..."
    ssh-agent -s > "$SSH_ENV"
    chmod 600 "$SSH_ENV"
    source "$SSH_ENV" > /dev/null
    ssh-add ~/.ssh/id_ed25519
}

# Load existing agent or start a new one
if [ -f "$SSH_ENV" ]; then
    source "$SSH_ENV" > /dev/null
    # Check if agent is still running
    if ! ps -p "$SSH_AGENT_PID" > /dev/null 2>&1; then
        start_agent
    fi
else
    start_agent
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

source "$HOME/.local/bin/env"

alias v='nvim'

eval $(keychain --eval --quiet id_rsa id_ed25519)



export PATH="$PATH:$HOME/bin/google-cloud-sdk/bin"


source /usr/share/nvm/init-nvm.sh

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

