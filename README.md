>┌─────────┐
>│ dotfile │
>└─────────┘

## neovim add tab to swithch buffer


# install
## install stow
- ubuntu
```
apt install stow
```
```
stow name
```
if you want you stow all
```
stow .
```

## Tmux
- Ctrl-B has been remapped to the backtick character (`). If you want to type the actual backtick character (`) itself, just hit the key twice.
- `%` has been remapped to `v`.
- Use `ctrl`+`h`,`j`,`k`,`l`vim movement keys for moving between panes.
- Status bar tells you date, time, user, and hostname. Especially useful with nested ssh sessions.



https://github.com/Parth/dotfiles#tmux
## todo
- how to specific brew path
- add lf


┌─────┐
│ zsh │
└─────┘
## zsh
### spaceship
```
brew install spaceship
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```
### zsh-plugins
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
- z.lua
[z.lua](https://github.com/skywind3000/z.lua)
```zsh
skywind3000/z.lua
git clone https://github.com/skywind3000/z.lua ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/z.lua
```

box

## ┌────────────┐
## │ KARABINNER │
## └────────────┘
```json
"rules": [
    {
        "description": "Change held-down f17 to left_shift",
        "manipulators": [
            {
                "from": {
                    "key_code": "f17",
                    "modifiers": {
                        "optional": [
                            "left_shift"
                        ]
                    }
                },
                "parameters": {
                    "basic.to_if_alone_timeout_milliseconds": 250,
                    "basic.to_if_held_down_threshold_milliseconds": 1
                },
                "to_if_alone": [
                    {
                        "key_code": "f17"
                    }
                ],
                "to_if_held_down": [
                    {
                        "key_code": "left_shift"
                    }
                ],
                "type": "basic"
            }
        ]
    },
```



# Font
┌──────────────┐
│ install font │
└──────────────┘

[jetbrains_mono](https://www.jetbrains.com/lp/mono/)


┌──────────┐
│ anaconda │
└──────────┘
## anaconda
### config
close default
```shell
conda config --set changeps1 False
```



┌──────────┐
│ imselect │
└──────────┘
[im-select](https://github.com/daipeihust/im-select)
``` shell
brew tap daipeihust/tap && brew install im-select
```
┌──────┐
│ nivm │
└──────┘
```shell
brew install pynvim
```


hellp


just download github desktop



┌─────┐
│ zsh │
└─────┘
## 优化zsh启动时间
[优化zsh](https://fly.meow-2.com/post/records/conda-faster.html)

┌────────┐
│ 输入法 │
└────────┘

## imselect
[im-select](https://github.com/daipeihust/im-select)


## Vimv
``` bash
curl https://raw.githubusercontent.com/thameera/vimv/master/vimv > ~/.local/bin/vimv && chmod +755 ~/.local/bin/vimv
```
