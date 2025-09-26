return {
  "neovim/nvim-lspconfig",
	enabled = false,
  dependencies = { "williamboman/mason.nvim" },
  config = function()
		local registry = require("mason-registry")

		local function on_attach(_, bufnr)
			local opts = { buffer = bufnr, noremap = true, silent = true }
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "<leader>lk", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
		end

		-- Server configs go here:
		local servers = {
			pyright = {
				pkg = "pyright",
				filetypes = { "python" },
				root_markers = { ".git", "pyproject.toml", "setup.py" },
			},
			tsserver = {
				pkg = "typescript-language-server",
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				root_markers = { "package.json", "tsconfig.json", ".git" },
			},
			lua_ls = {
				pkg = "lua-language-server",
				filetypes = { "lua" },
				root_markers = { ".git" },
				settings = {
					Lua = { diagnostics = { globals = { "vim" } } },
				},
			},
		}
		
		for name, cfg in pairs(servers) do
			vim.api.nvim_create_autocmd("FileType", {
				pattern = cfg.filetypes,
				callback = function()
					if not registry.is_installed(cfg.pkg) then
						registry.get_package(cfg.pkg):install()
					end
						
					local pkg = registry.get_package(cfg.pkg)
					local bin = pkg:get_install_path() .. "/bin/" .. cfg.pkg

					vim.lsp.start(vim.tbl_extend("force", cfg, {
						name = name,
						cmd = { bin, "--stdio" },
						root_dir = vim.fs.root(0, cfg.root_markers),
						on_attach = on_attach,
					}))
				end,
			})
		end
	end,
}

