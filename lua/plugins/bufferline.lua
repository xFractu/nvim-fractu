return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.opt.termguicolors = true
		require("bufferline").setup({})
		vim.keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>", {})
		vim.keymap.set("n", "<leader>nb", ":BufferLineCyclePrev<CR>", {})
	end,
}
