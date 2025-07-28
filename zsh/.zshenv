export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/bin:$PATH"
export PATH=$PATH:~/.local/bin
export EDITOR="nvim"


export PATH="$HOME/.duckdb/cli/latest:$PATH"

# export OBNOTE=${${(0A)$(printf %s $HOME/<->-NOTE/sigma(N))}[1]:A}
# export OBNOTE=${${(0A)~$HOME/<->-NOTE/sigma(N)}[1]:A}
# setopt extended_glob  # 启用 zsh 的高级通配符功能

paths=(
  $HOME/<->-NOTE/sigma(N)
  $HOME/note/sigma(N)
)

export OBNOTE=${paths[1]}  # 不使用 :A，保留符号链接路径
# echo 'hello from .zshenv'
