source $HOME/.config/zsh/.zsh_config
source $HOME/.config/zsh/.zsh_source
# source $HOME/.config/zsh/.zshenv # lf icon
source $HOME/.config/zsh/.zsh_alias
source $HOME/.config/zsh/.zsh_keymap
source $HOME/.config/zsh/.zsh_eval
source $HOME/.config/zsh/.zsh_function





#PROMPT='%B%F{003}  %B%F{015}%~%B%F{006} 󰅂%b%F{015} '
#RPROMPT='%B%F{015}%T'


#cat ~/.chache/wal/sequences


# export proxy="192.168.10.34:7890"


[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.



# export PATH="/Library/TeX/texbin:$PATH"


alias cs='() {
  local tmpfile=$(mktemp)
  curl -sSL "https://gitee.com/funnyzak/cli-cheatsheets/raw/main/cheatsheet.sh" -o "$tmpfile" && chmod +x "$tmpfile" && "$tmpfile" "$@" && rm -f "$tmpfile"
}'




# Go environment variables
export GOROOT=/usr/lib/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

if [ -f "$HOME/.env" ]; then
    source "$HOME/.env"
fi



# bindkey '^W' backward-kill-word
