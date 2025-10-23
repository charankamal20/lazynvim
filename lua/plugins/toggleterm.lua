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

		local scooter_term = Terminal:new({ cmd = "scooter", hidden = true })

		_G.EditLineFromScooter = function(file_path, line)
			if scooter_term and scooter_term:is_open() then
				scooter_term:close()
			end

			local current_path = vim.fn.expand("%:p")
			local target_path = vim.fn.fnamemodify(file_path, ":p")

			if current_path ~= target_path then
				vim.cmd.edit(vim.fn.fnameescape(file_path))
			end

			vim.api.nvim_win_set_cursor(0, { line, 0 })
		end

		local function open_scooter()
			if not scooter_term then
				scooter_term = require("toggleterm.terminal").Terminal:new({
					cmd = "scooter",
					direction = "float",
					close_on_exit = true,
					on_exit = function()
						scooter_term = nil
					end,
				})
			end
			scooter_term:open()
		end

		local function open_scooter_with_text(search_text)
			if scooter_term and scooter_term:is_open() then
				scooter_term:close()
			end

			local escaped_text = vim.fn.shellescape(search_text:gsub("\r?\n", " "))
			scooter_term = require("toggleterm.terminal").Terminal:new({
				cmd = "scooter --fixed-strings --search-text " .. escaped_text,
				direction = "float",
				close_on_exit = true,
				on_exit = function()
					scooter_term = nil
				end,
			})
			scooter_term:open()
		end
		-- REPLACE THIS: Integration-specific code here
		vim.keymap.set("n", "<C-f>", open_scooter, { desc = "Open scooter" })
		vim.keymap.set("v", "<leader>cr", function()
			local selection = vim.fn.getreg('"')
			vim.cmd('normal! "ay')
			open_scooter_with_text(vim.fn.getreg("a"))
			vim.fn.setreg('"', selection)
		end, { desc = "Search selected text in scooter" })
	end,
}
