return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			-- Basic options
			size = 12,
			open_mapping = [[<C-\>]], -- Default: Ctrl+\
			hide_numbers = true,
			shading_factor = 2,
			shade_filetypes = {},
			direction = "float", -- Can be "horizontal" or "vertical" too
			float_opts = {
				border = "curved", -- Popular: "single", "double", "curved"
				winblend = 0,
			},
			closed_on_exit = true,
			shell = vim.o.shell,
		})

		vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm", { desc = "Toggle floating terminal" })
		vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })

		vim.keymap.set(
			"n",
			"<leader>th",
			"<cmd>ToggleTerm direction=horizontal<CR>",
			{ desc = "Toggle horizontal terminal" }
		)
		vim.keymap.set(
			"n",
			"<leader>tv",
			"<cmd>ToggleTerm direction=vertical size=80<CR>",
			{ desc = "Toggle vertical terminal" }
		)

		vim.keymap.set("n", "<leader>td", ":ToggleTerm dir=%:p:h<CR>", { desc = "Open terminal in file dir" })
		function _G.set_terminal_keymaps()
			local opts = { noremap = true }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
			vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
			vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
			vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

			vim.keymap.set("n", "<C-h>", [[<C-W>h]], opts)
			vim.keymap.set("n", "<C-j>", [[<C-W>j]], opts)
			vim.keymap.set("n", "<C-k>", [[<C-W>k]], opts)
			vim.keymap.set("n", "<C-l>", [[<C-W>l]], opts)
		end

		vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()") -- Auto-apply for toggleterm terminals

		local Terminal = require("toggleterm.terminal").Terminal
		local htop = Terminal:new({ cmd = "htop", hidden = true })

		function _HTOP_TOGGLE()
			htop:toggle()
		end

		local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
		function _NCDU_TOGGLE()
			ncdu:toggle()
		end

		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

		function _LAZYGIT_TOGGLE()
			lazygit:toggle()
		end

		vim.keymap.set("n", "<leader>lg", ":lua _LAZYGIT_TOGGLE()<CR>")
	end,
}
