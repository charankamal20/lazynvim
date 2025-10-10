return {
	{
		"panghu-huang/theme-picker.nvim",
		lazy = false,
		config = function()
			require("theme-picker").setup({
				picker = {
					prompt_title = "Select Theme",
					layout_config = {
						width = 0.35,
						height = 0.5,
					},
				},
				themes = {
					{ name = "Catppuccin", colorscheme = "catppuccin" },
					{ name = "OneDark", colorscheme = "onedark" },
					{ name = "OneLight", colorscheme = "onelight" },
					{ name = "OneDark Vivid", colorscheme = "onedark_vivid" },
					{ name = "OneDark Dark", colorscheme = "onedark_dark" },
					{ name = "OneDark Vaporwave", colorscheme = "vaporwave" },
					{ name = "Vague", colorscheme = "vague" },
					{ name = "Zenwritten", colorscheme = "zenwritten" }, -- Zero hue and saturation version
					{ name = "Neobones", colorscheme = "neobones" }, -- Inspired by neovim.io
					{ name = "Vimbones", colorscheme = "vimbones" }, -- Inspired by vim.org
					{ name = "Rosebones", colorscheme = "rosebones" }, -- Inspired by Rosé Pine
				 { name = "Forestbones",  colorscheme = "forestbones" }, -- Inspired by Everforest
				 { name = "Nordbones",  colorscheme = "nordbones" }, -- Inspired by Nord
				 { name = "Tokyobones", colorscheme = "tokyobones" }, -- Inspired by Tokyo Night
				 { name = "Seoulbones",  colorscheme = "seoulbones" }, -- Inspired by Seoul256
				 { name = "Duckbones",  colorscheme = "duckbones" }, -- Inspired by Spaceduck
				 { name = "Zenburned",  colorscheme = "zenburned" }, -- Inspired by Zenburn
				 { name = "Kanagawabones", colorscheme = "kanagawabones" }, -- Inspired by Kanagawa
			 },
		 })
		 vim.api.nvim_set_keymap(
			 "n",
			 "<leader>tp",
			 ':lua require("theme-picker").open_theme_picker()<CR>',
			 { noremap = true, silent = true }
		 )
	 end,
 },
}
