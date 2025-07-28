export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/bin:$PATH"
export PATH=$PATH:~/.local/bin
export EDITOR="nvim"


export PATH="$HOME/.duckdb/cli/latest:$PATH"

# export OBNOTE=${${(0A)$(printf %s $HOME/<->-NOTE/sigma(N))}[1]:A}
export OBNOTE=${${(0A)~$HOME/{note,<->-NOTE}/sigma(N-/)}[1]:P}
# export OBNOTE=${${(0A)~$HOME/<->-NOTE/sigma(N-/)}[1]:A}

# echo 'hello from .zshenv'
