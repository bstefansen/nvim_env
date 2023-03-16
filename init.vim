autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType nerdtree setlocal relativenumber
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
set autoindent expandtab tabstop=4 shiftwidth=4
set nowrap
set number
set relativenumber
set cursorline
set autoread
au CursorHold * checktime

call plug#begin('~/AppData/local/nvim/autoload/plugged')
" Plug 'Yggdroot/indentLine'
" Plug 'ap/vim-css-color'
Plug 'haishanh/night-owl.vim'
" or with NeoBundle
" NeoBundle 'haishanh/night-owl.vim'
" or with Vundle
" Plugin 'haishanh/night-owl.vim'

""""" enable 24bit true color

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-sneak'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'EdenEast/nightfox.nvim' " Vim-Plug
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'p00f/nvim-ts-rainbow'
Plug 'ThePrimeagen/vim-be-good'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" or                                , { 'branch': '0.1.x' }
call plug#end()



nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

inoremap kk <enter>
" inoremap jj <esc>

" format json
map <leader>j :%!jq .<CR>

" paste everything from system clipboard
map <leader>p "+p<CR>

" copy everything to system clipboard
map <leader>y :%y+<CR>
map <leader>f :Telescope find_files hidden=true<CR>
map <leader>g :Telescope live_grep<CR>
map <leader>n :NERDTree<CR>
map <leader>vd :lua vim.lsp.buf.definition()<CR>
map <leader>t :!pipenv run pytest tests\unit\ -v --server localhost



lua <<EOF
require'lspconfig'.luau_lsp.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.pyright.setup{}

vim.cmd("colorscheme catppuccin-mocha")

require('telescope').setup {
	pickers = {
		live_grep = {
			additional_args = function(opts)
				return {"--hidden"}
			end
		}
	}
}

require'nvim-treesitter.configs'.setup {
	  ensure_installed = "c", "cpp",     -- one of "all", "language", or a list of languages
	    highlight = {
		    	enable = true,              -- false will disable the whole extension
				disable = {},  -- list of language that will be disabled
			},
	      rainbow = {
		          enable = true,
			  extended_mode = true -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			}
	    }

  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

