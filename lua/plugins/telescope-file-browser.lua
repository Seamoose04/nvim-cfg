return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").load_extension("file_browser")

    -- Keymaps
    vim.keymap.set("n", "<leader>fb", function()
      require("telescope").extensions.file_browser.file_browser({
        path = "%:p:h", -- start in current buffer's dir
        cwd = vim.loop.cwd(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        initial_mode = "normal",
      })
    end, { desc = "File browser (cwd)" })
  end,
}

