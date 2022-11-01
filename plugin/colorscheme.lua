vim.cmd[[set t_Co=256]]
vim.cmd[[set t_ut= ]]
vim.cmd[[let g:codedark_italics=1]]
vim.cmd[[let g:lightline={'active': {'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]}, 'component': { 'gitbranch': '' },'component_function': {'gitbranch': 'gitbranch#name'},'colorscheme': 'codedark'}]]
vim.cmd[[colorscheme codedark]]