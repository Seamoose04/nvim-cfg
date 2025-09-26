-- Set leader before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
require("config.lazy")

-- UI tweaks
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt["tabstop"] = 2
vim.opt["shiftwidth"] = 2

-- Colorscheme
vim.cmd.colorscheme("tokyonight")
