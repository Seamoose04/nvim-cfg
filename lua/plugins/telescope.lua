return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = vim.fn.executable("make") == 1,
		},
		"ThePrimeagen/harpoon",
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
		{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Search word under cursor" },
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 10,
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--ignore",
					"--hidden"
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = {
						"fd",
						"--type=f",
						"--strip-cwd-prefix",
						"--hidden",
						"--exclude", ".git"
					},
				},
			},
		})
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "harpoon")
	end,
}
