return {
	"arnamak/stay-centered.nvim",
	lazy = false,
	opts = {
		skip_filetypes = { "typescript" },
	},
	config = function()
		require("stay-centered").setup({
			offset = 20,
		})
	end,
}
