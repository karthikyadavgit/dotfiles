# INFO: This file is for the environment variables for zsh
# The shell looks for this file before any other

export PATH="$HOME/.local/bin:$PATH"

# We will point to the location of the .ZSHRC file
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# SSH agent persists every session
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export SSH_AGENT_PID=$(pgrep -u $USER ssh-agent)
