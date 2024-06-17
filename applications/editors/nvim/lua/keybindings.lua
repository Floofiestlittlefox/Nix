local builtin = require('telescope.builtin')
vim.keymap.set('n', '<localleader>ff', builtin.find_files, {})
vim.keymap.set('n', '<localleader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<localleader>fb', builtin.buffers, {})
vim.keymap.set('n', '<localleader>fh', builtin.help_tags, {})

vim.cmd("nnoremap <localleader>git :Neogit<cr>")
vim.cmd("nnoremap <localleader>ref :Telescope bibtex<cr>")
