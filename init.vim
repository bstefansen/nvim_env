set number
set relativenumber
set autoread
au CursorHold * checktime

call plug#begin('~/AppData/local/nvim/autoload/plugged')
Plug 'ThePrimeagen/vim-be-good'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" or                                , { 'branch': '0.1.x' }
call plug#end()


map <leader>f :Telescope find_files<CR>
map <leader>n :NERDTree<CR>

lua <<EOF
require'nvim-treesitter.configs'.setup {
	  ensure_installed = "c", "cpp",     -- one of "all", "language", or a list of languages
	    highlight = {
		    	enable = true,              -- false will disable the whole extension
				disable = {},  -- list of language that will be disabled
				  }
	    }
