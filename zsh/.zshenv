paths=(
  $HOME/<->-NOTE/sigma(N)
  $HOME/note/sigma(N)
)

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/bin:$PATH"
export PATH=$PATH:~/.local/bin
export EDITOR="nvim"
export PATH="$HOME/.duckdb/cli/latest:$PATH"

export NVIM_NOTES_NAME="nvim-notes"


# export OBNOTE=${${(0A)$(printf %s $HOME/<->-NOTE/sigma(N))}[1]:A}
# export OBNOTE=${${(0A)~$HOME/<->-NOTE/sigma(N)}[1]:A}
export OBNOTE=${paths[1]}
# echo 'hello from .zshenv'
