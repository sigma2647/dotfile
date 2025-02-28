stty -ixon
export HISTTIMEFORMAT="%F %T "
export MANPAGER="nvim +Man!"


[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dot='cd ~/dotfile'
alias v='nvim'
alias in='nix-shell -p'
alias ff='fastfetch'
alias t='tmux'
alias ta='tmux attach'

PS1='[\u@\h \W]\$ '

[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.
