set so=999
set number
set relativenumber
set autoread
au CursorHold * checktime

call plug#begin('~/AppData/local/nvim/autoload/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" or                                , { 'branch': '0.1.x' }
call plug#end()
 
 
map <leader>f :Telescope find_files<CR>
map <leader>n :NERDTree<CR>
