" ┌─────────┐
" │ website │
" └─────────┘
" https://github.com/esm7/obsidian-vimrc-support


"TODO: Learn regis
"n regis
"TODO: split vertital and horizontal"
"workspace:split-vertical
"workspace:split-horizontal

"=================
"basic mapping
"=================
imap jk <Esc>
imap ; <Esc>
imap ； <Esc>
"nmap S :w<CR>

nmap \ :
nmap j gj
nmap k gk
" I like using H and L for beginning/end of line
nmap H ^
nmap L $
vmap H ^
vmap L $

imap <C-h> <left>
imap <C-j> <down>
imap <C-k> <up>
imap <C-l> <right>
" Yank to system clipboard
set clipboard=unnamed



"=================
"advanced mapping
"=================

"=================
"Go back and forward with Ctrl+O and Ctrl+I
"(make sure to remove default Obsidian shortcuts for these to work)
"=================
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
"nmap <C-i> :forward
"=================
"move line up and down
"=================
exmap lineDown obcommand editor:swap-line-down
exmap lineUp obcommand editor:swap-line-up

"=================
"goto link
"=================
exmap gotolink obcommand editor:follow-link
exmap gotolinkwindow obcommand editor:open-link-in-new-leaf
nmap gf :gotolink
nmap gd :gotolink
nmap gD :gotolinkwindow
nmap gF :gotolinkwindow

"unmap <CR>
nmap <CR> :gotolink
nmap <C-CR> :gotolinkwindow
nmap <S-CR> :gotolinkwindow
nmap <BS> :back
" todo spli  indow


"=================
"toggle l r sidebar
"=================
exmap toggleLeft obcommand app:toggle-left-sidebar
exmap toggleRight obcommand app:toggle-right-sidebar
unmap <Space>
nmap <Space>m :toggleRight
nmap <Space>e :toggleLeft

"=================
"split
"=================
exmap vertital obcommand workspace:split-vertical
exmap horizontal obcommand workspace:split-horizontal

"nmap <Space>vs :vertital
"nmap <Space>sv :horizontal
"nmap <C-\> :vertital
"nmap <C--> :horizontal
nmap `v :vertital
nmap `b :horizontal


" ┌───────────┐
" │ NAVIGAION │
" └───────────┘
exmap focusTop obcommand editor:focus-top
exmap focusBut obcommand editor:focus-bottom
exmap focusLeft obcommand editor:focus-left
exmap focusRight obcommand editor:focus-right

nmap <C-k> :focusTop
nmap <C-j> :focusBut
nmap <C-h> :focusLeft
nmap <C-l> :focusRight

" ┌────────┐
" │ EDITOR │
" └────────┘
exmap showFile obcommand file-explorer:reveal-active-file
nmap <Space>ls :showFile
" 在goneovim打开文件
exmap goneovim obcommand open-with-default-app:open
nmap <Space>ob :goneovim
" 显示星标
exmap showStart obcommand starred:open
nmap <Space>s :showStart
" 锁定
exmap pin obcommand workspace:toggle-pin
nmap <Space>p :pin

" 标签面板
exmap tag obcommand tag-pane:open
nmap <Space>t :tag
" 复制url
exmap copyUrl obcommand workspace:copy-url
nmap <Space>cu :copyUrl

"Available commands: editor:save-file
exmap save obcommand editor:save-file
nmap S :save

exmap close obcommand workspace:close
nmap Q :close

"graph:open-local
exmap graph obcommand graph:open-local
nmap <Space>g :graph

"app:toggle-left-sidebar
"app:toggle-right-sidebar
"
"exmap toggle-left obcommand app:toggle-left-sidebar
"exmap toggle-right obcommand app:toggle-right-sidebar
"nmap <leader>e 
"nmap <leader>m

"app:toggle-left-sidebar
"app:toggle-right-sidebar

" Use Ctrl+P to open a new tab
" (make sure to remove default Obsidian shortcuts for these to work)
" (make sure to remove default Obsidian shortcuts for these to work)
""editor:swap-line-down

"Available commands: editor:save-file
"editor:follow-link
"editor:open-link-in-new-leaf
"editor:focus-top
"editor:focus-bottom
"editor:focus-left
"editor:focus-right
"workspace:toggle-pin
"workspace:split-vertical
"workspace:split-horizontal
"workspace:edit-file-title
"workspace:copy-path
"workspace:copy-url
"workspace:undo-close-pane
"workspace:export-pdf
"editor:rename-heading
"calendar:show-calendar-view
"calendar:open-weekly-note
"calendar:reveal-active-note
"obsidian-excalidraw-plugin:excalidraw-download-lib
"obsidian-excalidraw-plugin:excalidraw-open
"obsidian-excalidraw-plugin:excalidraw-open-on-current
"obsidian-excalidraw-plugin:excalidraw-insert-transclusion
"obsidian-excalidraw-plugin:excalidraw-insert-last-active-transclusion
"obsidian-excalidraw-plugin:excalidraw-autocreate
"obsidian-excalidraw-plugin:excalidraw-autocreate-on-current
"obsidian-excalidraw-plugin:excalidraw-autocreate-and-embed
"obsidian-excalidraw-plugin:excalidraw-autocreate-and-embed-on-current
"obsidian-excalidraw-plugin:export-svg
"obsidian-excalidraw-plugin:export-png
"obsidian-excalidraw-plugin:toggle-lock
"obsidian-excalidraw-plugin:insert-link
"obsidian-excalidraw-plugin:insert-image
"obsidian-excalidraw-plugin:insert-md
"obsidian-excalidraw-plugin:insert-LaTeX-symbol
"obsidian-excalidraw-plugin:toggle-excalidraw-view
"obsidian-excalidraw-plugin:convert-to-excalidraw
"obsidian-excalidraw-plugin:convert-excalidraw
"obsidian-outliner:fold
"obsidian-outliner:unfold
"obsidian-outliner:move-list-item-up
"obsidian-outliner:move-list-item-down
"obsidian-outliner:indent-list
"obsidian-outliner:outdent-list
"url-into-selection:paste-url-into-selection
"templater-obsidian:insert-templater
"templater-obsidian:replace-in-file-templater
"templater-obsidian:jump-to-next-cursor-location
"templater-obsidian:create-new-note-from-template
"templater-obsidian:template/bash.md
"templater-obsidian:template/jupyter.md
"app:go-back
"app:go-forward
"app:open-vault
"theme:use-dark
"theme:use-light
"editor:open-search
"editor:open-search-replace
"app:open-settings
"markdown:toggle-preview
"app:delete-file
"workspace:close
"workspace:close-others
"app:toggle-left-sidebar
"app:toggle-right-sidebar
"app:toggle-default-new-pane-mode
"app:open-help
"editor:focus
"editor:toggle-fold
"editor:fold-all
"editor:unfold-all
"editor:insert-wikilink
"editor:insert-embed
"editor:insert-link
"editor:insert-tag
"editor:set-heading
"editor:toggle-bold
"editor:toggle-italics
"editor:toggle-strikethrough
"editor:toggle-highlight
"editor:toggle-code
"editor:toggle-blockquote
"editor:toggle-comments
"editor:toggle-bullet-list
"editor:toggle-numbered-list
"editor:toggle-checklist-status
"editor:swap-line-up
"editor:swap-line-down
"editor:attach-file
"editor:delete-paragraph
"editor:toggle-spellcheck
"file-explorer:new-file
"file-explorer:new-file-in-new-pane
"app:reload
"file-explorer:open
"file-explorer:reveal-active-file
"file-explorer:move-file
"global-search:open
"graph:open
"graph:open-local
"graph:animate
"backlink:open
"backlink:open-backlinks
"backlink:toggle-backlinks-in-document
"tag-pane:open
"daily-notes
"daily-notes:goto-prev
"daily-notes:goto-next
"insert-template
"insert-current-date
"insert-current-time
"note-composer:merge-file
"note-composer:split-file
"note-composer:extract-heading
"command-palette:open
"starred:open
"starred:star-current-file
"markdown-importer:open
"random-note
"outline:open
"outline:open-for-current
"open-with-default-app:open
"open-with-default-app:show
"workspaces:load
"workspaces:save-and-load
"workspaces:open-modal
"file-recovery:open
"
"
"Available commands: editor:save-file
"editor:follow-link
"editor:open-link-in-new-leaf
"editor:focus-top
"editor:focus-bottom
"editor:focus-left
"editor:focus-right
"workspace:toggle-pin
"workspace:split-vertical
"workspace:split-horizontal
"workspace:edit-file-title
"workspace:copy-path
"workspace:copy-url
"workspace:undo-close-pane
"workspace:export-pdf
"editor:rename-heading
"calendar:show-calendar-view
"calendar:open-weekly-note
"calendar:reveal-active-note
"table-editor-obsidian:next-row
"table-editor-obsidian:next-cell
"table-editor-obsidian:previous-cell
"table-editor-obsidian:format-table
"table-editor-obsidian:format-all-tables
"table-editor-obsidian:insert-column
"table-editor-obsidian:insert-row
"table-editor-obsidian:escape-table
"table-editor-obsidian:left-align-column
"table-editor-obsidian:center-align-column
"table-editor-obsidian:right-align-column
"table-editor-obsidian:move-column-left
"table-editor-obsidian:move-column-right
"table-editor-obsidian:move-row-up
"table-editor-obsidian:move-row-down
"table-editor-obsidian:delete-column
"table-editor-obsidian:delete-row
"table-editor-obsidian:sort-rows-ascending
"table-editor-obsidian:sort-rows-descending
"table-editor-obsidian:evaluate-formulas
"table-editor-obsidian:table-control-bar
"templater-obsidian:insert-templater
"templater-obsidian:replace-in-file-templater
"templater-obsidian:jump-to-next-cursor-location
"templater-obsidian:create-new-note-from-template
"templater-obsidian:template/bash.md
"templater-obsidian:template/jupyter.md
"obsidian-excalidraw-plugin:excalidraw-download-lib
"obsidian-excalidraw-plugin:excalidraw-open
"obsidian-excalidraw-plugin:excalidraw-open-on-current
"obsidian-excalidraw-plugin:excalidraw-insert-transclusion
"obsidian-excalidraw-plugin:excalidraw-insert-last-active-transclusion
"obsidian-excalidraw-plugin:excalidraw-autocreate
"obsidian-excalidraw-plugin:excalidraw-autocreate-on-current
"obsidian-excalidraw-plugin:excalidraw-autocreate-and-embed
"obsidian-excalidraw-plugin:excalidraw-autocreate-and-embed-on-current
"obsidian-excalidraw-plugin:export-svg
"obsidian-excalidraw-plugin:search-text
"obsidian-excalidraw-plugin:export-png
"obsidian-excalidraw-plugin:toggle-lock
"obsidian-excalidraw-plugin:delete-file
"obsidian-excalidraw-plugin:insert-link
"obsidian-excalidraw-plugin:insert-link-to-element
"obsidian-excalidraw-plugin:insert-image
"obsidian-excalidraw-plugin:release-notes
"obsidian-excalidraw-plugin:tray-mode
"obsidian-excalidraw-plugin:insert-md
"obsidian-excalidraw-plugin:insert-LaTeX-symbol
"obsidian-excalidraw-plugin:toggle-excalidraw-view
"obsidian-excalidraw-plugin:convert-to-excalidraw
"obsidian-excalidraw-plugin:convert-excalidraw
"note-refactor-obsidian:app:extract-selection-first-line
"note-refactor-obsidian:app:extract-selection-content-only
"note-refactor-obsidian:app:extract-selection-autogenerate-name
"note-refactor-obsidian:app:split-note-first-line
"note-refactor-obsidian:app:split-note-content-only
"note-refactor-obsidian:app:split-note-by-heading-h1
"note-refactor-obsidian:app:split-note-by-heading-h2
"note-refactor-obsidian:app:split-note-by-heading-h3
"obsidian-local-images:download-images
"obsidian-local-images:download-images-all
"obsidian-style-settings:show-style-settings-leaf
"obsidian-minimal-settings:increase-body-font-size
"obsidian-minimal-settings:decrease-body-font-size
"obsidian-minimal-settings:toggle-minimal-dark-cycle
"obsidian-minimal-settings:toggle-minimal-light-cycle
"obsidian-minimal-settings:toggle-hidden-borders
"obsidian-minimal-settings:toggle-colorful-headings
"obsidian-minimal-settings:toggle-minimal-focus-mode
"obsidian-minimal-settings:cycle-minimal-table-width
"obsidian-minimal-settings:cycle-minimal-image-width
"obsidian-minimal-settings:cycle-minimal-iframe-width
"obsidian-minimal-settings:toggle-minimal-img-grid
"obsidian-minimal-settings:toggle-minimal-switch
"obsidian-minimal-settings:toggle-minimal-light-default
"obsidian-minimal-settings:toggle-minimal-light-white
"obsidian-minimal-settings:toggle-minimal-light-tonal
"obsidian-minimal-settings:toggle-minimal-light-contrast
"obsidian-minimal-settings:toggle-minimal-dark-default
"obsidian-minimal-settings:toggle-minimal-dark-tonal
"obsidian-minimal-settings:toggle-minimal-dark-black
"obsidian-minimal-settings:toggle-minimal-atom-light
"obsidian-minimal-settings:toggle-minimal-default-light
"obsidian-minimal-settings:toggle-minimal-gruvbox-light
"obsidian-minimal-settings:toggle-minimal-macos-light
"obsidian-minimal-settings:toggle-minimal-notion-light
"obsidian-minimal-settings:toggle-minimal-nord-light
"obsidian-minimal-settings:toggle-minimal-solarized-light
"obsidian-minimal-settings:toggle-minimal-things-light
"obsidian-minimal-settings:toggle-minimal-atom-dark
"obsidian-minimal-settings:toggle-minimal-dracula-dark
"obsidian-minimal-settings:toggle-minimal-default-dark
"obsidian-minimal-settings:toggle-minimal-gruvbox-dark
"obsidian-minimal-settings:toggle-minimal-macos-dark
"obsidian-minimal-settings:toggle-minimal-nord-dark
"obsidian-minimal-settings:toggle-minimal-notion-dark
"obsidian-minimal-settings:toggle-minimal-solarized-dark
"obsidian-minimal-settings:toggle-minimal-things-dark
"workspaces-plus:open-workspaces-plus
"app:go-back
"app:go-forward
"app:open-vault
"theme:use-dark
"theme:use-light
"app:open-settings
"markdown:toggle-preview
"workspace:close
"workspace:close-others
"app:delete-file
"app:toggle-left-sidebar
"app:toggle-right-sidebar
"app:toggle-default-new-pane-mode
"app:open-help
"app:reload
"app:show-debug-info
"file-explorer:new-file
"file-explorer:new-file-in-new-pane
"editor:open-search
"editor:open-search-replace
"editor:focus
"editor:toggle-fold
"editor:fold-all
"editor:unfold-all
"editor:insert-wikilink
"editor:insert-embed
"editor:insert-link
"editor:insert-tag
"editor:set-heading
"editor:toggle-bold
"editor:toggle-italics
"editor:toggle-strikethrough
"editor:toggle-highlight
"editor:toggle-code
"editor:toggle-blockquote
"editor:toggle-comments
"editor:toggle-bullet-list
"editor:toggle-numbered-list
"editor:toggle-checklist-status
"editor:cycle-list-checklist
"editor:swap-line-up
"editor:swap-line-down
"editor:attach-file
"editor:delete-paragraph
"editor:toggle-spellcheck
"file-explorer:open
"file-explorer:reveal-active-file
"file-explorer:move-file
"global-search:open
"switcher:open
"graph:open
"graph:open-local
"graph:animate
"backlink:open
"backlink:open-backlinks
"backlink:toggle-backlinks-in-document
"tag-pane:open
"daily-notes
"daily-notes:goto-prev
"daily-notes:goto-next
"insert-template
"insert-current-date
"insert-current-time
"note-composer:merge-file
"note-composer:split-file
"note-composer:extract-heading
"command-palette:open
"starred:open
"starred:star-current-file
"markdown-importer:open
"random-note
"outline:open
"outline:open-for-current
"open-with-default-app:open
"open-with-default-app:show
"workspaces:load
"workspaces:save-and-load
"workspaces:open-modal
"file-recovery:open
"editor:toggle-source
"obsidian-admonition:insert-col2
"obsidian-admonition:insert-col2-with-title
"obsidian-admonition:collapse-admonitions
"obsidian-admonition:open-admonitions
"obsidian-admonition:insert-admonition
"workspaces-plus:知识体系管理
"workspaces-plus:量化投资
"workspaces-plus:大屏
"workspaces-plus:小屏模式
"workspaces-plus:graph_mode
"workspaces-plus:手机
"workspaces-plus:阅读模式
"workspaces-plus:大屏001
