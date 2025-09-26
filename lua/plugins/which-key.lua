return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			delay = 200,
			triggers = { "<leader>" }
		})

		wk.add({
			{ "<leader>f", group = "Files" },
			{ "<leader>g", group = "Git" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>t", group = "Telescope" },
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Debug" },
		})
	end,
}
