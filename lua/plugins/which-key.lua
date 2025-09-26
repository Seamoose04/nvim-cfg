return {
	"folke/which-key.nvim",
	dependencies = {
		"nvim-mini/mini.icons",
		"nvim-tree/nvim-web-devicons"
	},
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			plugins = {
				spelling = true,
			},
			replace = {
				["<leader>"] = "SPC",
			},
			win = {
				border = "rounded",
				position = "bottom",
			},
		})

		wk.add({
			{ "<leader>f", group = "Files" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },


			{ "<leader>g", group = "Git" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>t", group = "Telescope" },
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>w", group = "Windows" },
			{ "<leader>b", group = "Buffers" },
			{ "<leader>q", group = "Quit/Session" },
		})
	end,
}
