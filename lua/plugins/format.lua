return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
      },
      format_on_save = false,
    })

    -- Utility: format current function (or visual selection if active)
    local function format_scope()
      local mode = vim.fn.mode()
      if mode == "v" or mode == "V" or mode == "␖" then
        -- Visual selection → format that range
        conform.format({ async = true, lsp_fallback = true, range = true })
      else
        -- Use treesitter to detect current function/block range
        local ts_utils = require("nvim-treesitter.ts_utils")
        local node = ts_utils.get_node_at_cursor()
        while node and node:type() ~= "function_declaration"
          and node:type() ~= "function_definition"
          and node:type() ~= "method_declaration"
          and node:type() ~= "block"
        do
          node = node:parent()
        end
        if node then
          local start_row, _, end_row, _ = node:range()
          conform.format({
            async = true,
            lsp_fallback = true,
            range = { start_row + 1, 0, end_row + 1, 0 },
          })
        else
          -- fallback: whole file
          conform.format({ async = true, lsp_fallback = true })
        end
      end
    end

    -- Keymap for manual function/selection formatting
    vim.keymap.set({ "n", "v" }, "<leader>f", format_scope,
      { desc = "Format current function or selection" })

    -- Auto format after paste (only pasted range)
    vim.api.nvim_create_autocmd("TextYankPost", {
      callback = function(event)
        if event.operator == "p" or event.operator == "P" then
          conform.format({
            async = true,
            lsp_fallback = true,
            range = true,
          })
        end
      end,
    })

    -- Auto format after typing "}" (format enclosing block)
    vim.api.nvim_create_autocmd("InsertLeave", {
      pattern = "*",
      callback = function()
        local line = vim.api.nvim_get_current_line()
        if line:match("}$") then
          format_scope()
        end
      end,
    })
  end,
}

