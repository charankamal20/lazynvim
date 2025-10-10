return {
	"olexsmir/gopher.nvim",
	config = function()
		require("gopher").setup()
		vim.keymap.set("n", "<leader>gsj", ":GoTagAdd json <CR>", {})
		vim.keymap.set("n", "<leader>gsy", ":GoTagAdd yaml <CR>", {})
		vim.keymap.set("n", "<leader>rr", ":GoIfErr <CR>", {})
		vim.keymap.set("n", "<leader>cm", ":GoCmt <CR><ESC>", {})
	end,
	build = function()
		vim.cmd([[silent! GoInstallDeps]])
	end,
}
