return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2", -- new version
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    -- Add current file
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end,
      { desc = "Harpoon add file" })

    -- Toggle quick menu
    vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Harpoon menu" })

    -- Jump to files 1-5
    vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end,
			{ desc = "Jump to file 1"})
    vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end,
			{ desc = "Jump to file 2"})
    vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end,
			{ desc = "Jump to file 3"})
    vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end,
			{ desc = "Jump to file 4"})
    vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end,
			{ desc = "Jump to file 5"})

    -- Next/prev file
    vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end,
			{ desc = "Jump to next"})
    vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end,
			{ desc = "Jump to previous"})
  end,
}

