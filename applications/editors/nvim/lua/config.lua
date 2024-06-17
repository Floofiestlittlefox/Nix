vim.g.mapleader = "\\" -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`
vim.wo.relativenumber = true
vim.g.typst_pdf_viewer = "okular"
vim.cmd("syntax enable")
vim.g.vimtex_view_general_viewer = 'okular'
--vim.g.vimtex_view_general_options = "--unique file:@pdf\#src:@line@tex"
