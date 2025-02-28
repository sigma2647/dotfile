-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = {
	font_size = 16,
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font("JetBrainsMonoNL Nerd Font", { weight = "Regular" }),
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "RESIZE",
	show_new_tab_button_in_tab_bar = false,
	macos_window_background_blur = 70,
	adjust_window_size_when_changing_font_size = false,

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	-- default_prog = { "/usr/local/bin/tmux" }, -- 默认启动方式 "zsh" "bash" "tmux"
}

-- This will hold the configuration.
-- local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"

-- and finally, return the configuration to wezterm
return config
