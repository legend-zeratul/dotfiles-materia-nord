syntax enable
set number
set expandtab
set shiftwidth=2

set autoindent
set smartindent

if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

if (has('termguicolors'))
  set termguicolors
endif

colorscheme nord
hi Normal guibg=NONE ctermbg=NONE
"hi Normal ctermbg=NONE

"Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

"Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'scrooloose/nerdtree'

"List ends here. Plugins become visible to Vim after this call.
call plug#end()

"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

