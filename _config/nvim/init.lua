HOME = os.getenv('HOME')

--------------------------------------------------
-- Options
vim.opt.background = 'dark'
vim.opt.backup = true
vim.opt.backupdir = HOME .. '/.local/state/nvim/backup//'
vim.opt.cmdheight = 2
vim.opt.colorcolumn = '80,120'
vim.opt.cursorline = true
vim.opt.diffopt = 'internal,filler,vertical'
vim.opt.expandtab = true
vim.opt.history = 1000
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.listchars = {eol = ' ', tab = '▸ ', trail = '·', extends = '»', precedes = '«'}
vim.opt.joinspaces = false
vim.opt.relativenumber = true
-- vim.opt.runtimepath:append('~/.config/nvim/vlime/vim')
vim.opt.scrolloff = 5
vim.opt.showmatch = true
vim.opt.smartcase = true
--vim.opt.statusline = "%<%f %m%r%w%y%q%{fugitive#statusline()}%=%-14.(%l,%c%V%) %P"
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.undofile = true
vim.opt.visualbell = true
vim.opt.wildignore = ".git,.hg,.svn,*.a,*.class,*.gif,*.jpg,*.o,*.obj,*.png,*.pyc,*.so,*.swp,*.fasl,*.fas,*.lib"
vim.opt.wrap = false



-- Only show cursorline in the current window and in normal mode.
-- https://github.com/arnvald/viml-to-lua/blob/main/lua/settings.lua
vim.cmd([[
  augroup cline
      au!
      au WinLeave * set nocursorline
      au WinEnter * set cursorline
      au InsertEnter * set nocursorline
      au InsertLeave * set cursorline
  augroup END
]])


-- Restore last cursor position when opening a file
-- :help restore-cursor
vim.cmd([[
  autocmd BufRead * autocmd FileType <buffer> ++once
    \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
]])

-- jbuilder syntax highlighting
vim.cmd([[
  autocmd BufNewFile,BufRead *.json.jbuilder set ft=ruby
]])

--------------------------------------------------
-- ALE options
vim.g.ale_lint_delay = 5000
vim.g.ale_lint_on_text_changed = 'normal'
vim.g.ale_lint_on_insert_leave = 1
vim.g.ale_virtualtext_cursor = 'current'

-- Use `bundle exec rubocop` instead of `rubocop`
vim.g.ale_ruby_rubocop_executable = 'bundle'


--------------------------------------------------
-- AUTOCOMMANDS

--------------------------------------------------
-- Custom Mappings
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function cmap(shortcut, command)
  map('c', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

-- Complete previous lines
imap('<C-l>', '<C-x><C-l>')

-- Move to a window and maximize the area.
nmap('<C-k>', '<C-w>k<C-w>_<C-w><Bar>')
nmap('<C-j>', '<C-w>j<C-w>_<C-w><Bar>')
nmap('<C-h>', '<C-w>h126<C-w><Bar>')
nmap('<C-l>', '<C-w>l126<C-w><Bar>')

-- Stop highlighting
nmap('<leader><space>', ':noh<cr>')

-- Highlight the word under the cursor without jumping (thanks ChatGTP).
nmap('<Leader>*', ":let @/ = '\\<<C-r><C-w>\\>'<CR>:set hls<CR>")

-- Strip all trailing whitespace in the current file
nmap('<leader>W', ":%s/\\s\\+$//<cr>:let @/=''<CR>")

-- Terminal mode mappings
-- tnoremap <Esc> <C-\><C-n>

-- Uses git-grep to search on all tracked files inside the
-- repository, putting results in quickfix buffer.
-- vmap <leader>vg "vy:Ggrep <C-R>v<cr>:copen<cr>

-- Open files in the same directory as the current directory
vim.cmd([[
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
]])

-- Cycle buffers
nmap('<C-n>', ':bnext<CR>')
nmap('<C-p>', ':bprev<CR>')



--------------------------------------------------
-- RUNNING TESTS
-- Adapted from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
vim.cmd([[
function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction
]])

vim.cmd([[
function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction
]])

vim.cmd([[
function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction
]])

vim.cmd([[
function! RunTests(filename)
    " Write all buffers and run tests for the given filename
    :wa
    let dox_do = (exists('$DOX_CLOUD_PERSONAL_INSTANCE') && $DOX_CLOUD_PERSONAL_INSTANCE != '') ? 'dox-do ' : ''

    if match(a:filename, '\.feature$') != -1
        exec ":split term://script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":split term://". dox_do . "script/test " . a:filename
        elseif filereadable("bin/rspec")
            exec ":split term://time " . dox_do . "./bin/rspec " . a:filename
        elseif filereadable("Gemfile")
            exec ":split term://time " . dox_do . "bundle exec rspec " . a:filename
        else
            exec ":split term://time " . dox_do . "rspec " . a:filename
        end
    end
endfunction
]])

--------------------------------------------------
-- PROMOTE A VARIABLE TO RSPEC LET.
-- From https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
vim.cmd([[
function! PromoteToLet()
  normal! dd
  normal! P
  .s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  normal ==
endfunction
]])


--------------------------------------------------
-- The commands for ruby files
vim.cmd([[
augroup ruby_custom_mappings
  autocmd!
  autocmd FileType ruby nnoremap <buffer> <leader>p :call PromoteToLet()<cr>
  autocmd FileType ruby nnoremap <buffer> <leader>t :call RunTestFile()<cr>
  autocmd FileType ruby nnoremap <buffer> <leader>T :call RunNearestTest()<cr>
augroup END
]])


--------------------------------------------------
-- VINDENT.VIM
vim.g.vindent_motion_OO_prev   = '[=' -- jump to prev block of same indent.
vim.g.vindent_motion_OO_next   = ']=' -- jump to next block of same indent.
vim.g.vindent_motion_more_prev = '[+' -- jump to prev line with more indent.
vim.g.vindent_motion_more_next = ']+' -- jump to next line with more indent.
vim.g.vindent_motion_less_prev = '[-' -- jump to prev line with less indent.
vim.g.vindent_motion_less_next = ']-' -- jump to next line with less indent.
vim.g.vindent_motion_diff_prev = '[;' -- jump to prev line with different indent.
vim.g.vindent_motion_diff_next = '];' -- jump to next line with different indent.
vim.g.vindent_motion_XX_ss     = '[p' -- jump to start of the current block scope.
vim.g.vindent_motion_XX_se     = ']p' -- jump to end   of the current block scope.
vim.g.vindent_object_XX_ii     = 'ii' -- select current block.
vim.g.vindent_object_XX_ai     = 'ai' -- select current block + one extra line  at beginning.
vim.g.vindent_object_XX_aI     = 'aI' -- select current block + two extra lines at beginning and end.
vim.g.vindent_jumps            = 1    -- make vindent motion count as a |jump-motion| (works with |jumplist|).


--------------------------------------------------
-- PACKAGES
require "paq" {
    "savq/paq-nvim", -- Let Paq manage itself

    { "nvim-lua/plenary.nvim" }, -- Required by telescope

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    { "jpalardy/vim-slime" },
    { "ngmy/vim-rubocop" },
    { "dense-analysis/ale" },
    { "github/copilot.vim" },
    { "tpope/vim-rhubarb" },
    -- { "tpope/fugitive-gitlab.vim" },
    { "tpope/vim-fugitive" },
    { "shumphrey/fugitive-gitlab.vim" },
    { "nvim-telescope/telescope.nvim", branch = '0.1.x' },
    { 'lewis6991/gitsigns.nvim' },
    { 'slim-template/vim-slim' },
    { 'jessekelighine/vindent.vim' },

    -- { 'vlime/vlime' }, installed manually, see `~/.config/nvim/vlime/` and `vim.opt.runtimepath` above.
    { 'kovisoft/paredit' },
    { 'kdheepak/lazygit.nvim' },
    { 'kchmck/vim-coffee-script' },

    -- Colorschemes
    { "overcache/NeoSolarized", opt = true },
    -- { "ericbn/vim-solarized", opt = true },
    { "NLKNguyen/papercolor-theme", opt = true },
    { "folke/tokyonight.nvim" },
    { "ellisonleao/gruvbox.nvim", opt = true },
}

--------------------------------------------------
-- LazyGit
nmap('<leader>gg', ':LazyGit<CR>')

--------------------------------------------------
-- TELESCOPE
require("telescope").setup{
    defaults = {
        file_ignore_patterns = { "^vendor/" },
    }
}

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})
vim.keymap.set('n', '<leader>vg', telescope_builtin.grep_string, {})


--------------------------------------------------
-- Gitsigns
require('gitsigns').setup{
    current_line_blame = true,
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk{wrap=false} end)
            return '<Ignore>'
        end, {expr=true})

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk{wrap=false} end)
            return '<Ignore>'
        end, {expr=true})

        -- Actions
        map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line{full=true} end)
        --map('n', '<leader>tb', gs.toggle_current_line_blame)
        --map('n', '<leader>hd', gs.diffthis)
        --map('n', '<leader>hD', function() gs.diffthis('~') end)
        --map('n', '<leader>td', gs.toggle_deleted)

        -- Text object
        --map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}


--------------------------------------------------
-- vim-slime
vim.g.slime_target = "tmux"


--------------------------------------------------
-- Search with fugitive's :Ggrep
vim.cmd([[
  vmap <leader>vg "vy:Ggrep <C-R>v<cr>:copen<cr>
]])

--------------------------------------------------
-- Colorschemes

-- Gruvbox
vim.g.gruvbox_italic = 1
vim.g.gruvbox_improved_strings = 1
vim.g.gruvbox_improved_warnings = 1
--vim.g.gruvbox_transparent_bg = 1
vim.g.airline_theme = 'gruvbox'

vim.cmd.packadd('gruvbox.nvim')
--vim.cmd.colorscheme('gruvbox')

-- NeoSolarized
vim.g.neosolarized_italic = 1
--vim.cmd.colorscheme('NeoSolarized')

-- Other colorschemes
-- vim.cmd.colorscheme('blue')
vim.cmd[[colorscheme tokyonight-moon]]

-- vim: set sw=4 ts=4 et:
