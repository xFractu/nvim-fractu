return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"jsonls",
				"angularls",
				"lua_ls",
				"jdtls",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Capacidades de nvim-cmp para todos los servidores
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.enable({
				"ts_ls",
				"html",
				"cssls",
				"jsonls",
				"angularls",
				"lua_ls",
				"jdtls",
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
