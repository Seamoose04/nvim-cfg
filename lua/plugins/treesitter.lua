return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			-- parsers you want installed
			ensure_installed = {
				"lua", "python", "javascript", "typescript", "c", "cpp", "bash", "json", "yaml", "html", "css"
			},
			highlight = {
				enable = true, -- better syntax highlighting
			},
			indent = {
				enable = true, -- smarter indentation
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",       -- start selection
					node_incremental = "<CR>",     -- expand to next node
					scope_incremental = "<S-CR>",  -- expand to scope
					node_decremental = "<BS>",     -- shrink
				},
			},
		})
	end,
}

