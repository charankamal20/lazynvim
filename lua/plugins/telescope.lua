return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>jd", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>js", builtin.lsp_workspace_symbols, {})
			vim.keymap.set("n", "<leader>jb", builtin.lsp_document_symbols, {})

			vim.keymap.set("n", "<leader>jh", builtin.help_tags, {})
			vim.keymap.set("n", "<M-j>", ":cnext<CR>", {})
			vim.keymap.set("n", "<M-k>", ":cprev<CR>", {})
			vim.keymap.set("n", "<leader>bn", function()
				builtin.find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end)

			require("plugins.telescope.multigrep").setup()
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")
		end,
	},
}
