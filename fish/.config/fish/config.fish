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
alias ta='tmux attach'
alias l='y'
alias ff='fastfetch'
alias cursor='cursor --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime'


alias oo="cd $HOME/note/sigma"
alias dot='cd ~/dotfile'
alias pc='proxychains4'


# zoxide (with custom command 'cd')
zoxide init --cmd cd fish | source
zoxide init fish | source


# starship prompt
starship init fish | source

# direnv
direnv hook fish | source

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


set -gx PATH $HOME/bin $PATH
