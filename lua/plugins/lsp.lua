return {
	"neovim/nvim-lspconfig",
	lazy = false,
	priority = 100,
	dependencies = { "williamboman/mason.nvim" },
	keys = {
		{ "<leader>ld", vim.lsp.buf.definition, desc = "Go to definition" },
		{ "<leader>lk", vim.lsp.buf.hover, desc = "Show hover info" },
		{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename symbol" },
		{ "<leader>la", vim.lsp.buf.code_action, desc = "Code action" },
	},
	config = function()
		-- Server configs go here:
		local servers = {
			clangd = {
				pkg = "clangd",
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
				root_markers = { "compile_commands.json", ".git" },
				cmd = { "clangd", "--background-index", "--clang-tidy" },
			},
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
					local mason = require("mason")
					local registry = require("mason-registry")
					local mason_path = require("mason.settings").current.install_root_dir

					local function start_lsp()
						local bin = mason_path .. "/bin/" .. cfg.pkg
						if vim.fn.executable(bin) == 0 then
							vim.notify(
								"LSP binary for " .. cfg.pkg .. " not found at " .. bin ..
								"\nTry running :Mason and installing it manually.",
								vim.log.levels.WARN
							)
							return
						end

						vim.lsp.start(vim.tbl_extend("force", cfg, {
							name = name,
							cmd = { bin, "--stdio" },
							root_dir = vim.fs.root(0, cfg.root_markers),
						}))

						vim.notify("Started LSP: " .. cfg.pkg, vim.log.levels.INFO)
					end

					-- Get or install package
					local pkg = registry.get_package(cfg.pkg)
					if not pkg:is_installed() then
						vim.notify("Installing missing LSP: " .. cfg.pkg .. " ...", vim.log.levels.INFO)
						pkg:install()

						-- Wait for install to complete
						pkg:on("install:success", function()
							vim.schedule(function()
								vim.notify("LSP installed: " .. cfg.pkg, vim.log.levels.INFO)
								start_lsp()
							end)
						end)
					else
						start_lsp()
					end
				end,
			})
		end
	end,
}
