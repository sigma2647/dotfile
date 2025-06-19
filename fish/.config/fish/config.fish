# if status is-interactive
#     # Commands to run in interactive sessions can go here
# end


source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end


alias g='lazygit'
alias nvimrc='nvim ~/.config/nvim/'
alias v='nvim'
alias t='tmux'
alias l='y'

alias ta='tmux attach'

alias oo="cd $HOME/note/sigma"
alias dot='cd ~/dotfile'
alias pc='proxychains4'


starship init fish | source

set -Ux EDITOR nvim
set -Ux VISUAL nvim


function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
