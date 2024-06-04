local sidebar = require("sidebar-nvim")
local opts = {
	open = true,
	sections = { "datetime", "files", "git", "containers"},
}
sidebar.setup(opts)
