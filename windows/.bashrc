stty -ixon
export HISTTIMEFORMAT="%F %T "
export MANPAGER="nvim +Man!"

export PATH=$PATH:$HOME/bin


[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dot='cd ~/dotfile'
alias v='nvim'
alias in='nix-shell -p'
alias ff='fastfetch'
alias t='tmux'
alias ta='tmux attach'
alias l=y



function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


