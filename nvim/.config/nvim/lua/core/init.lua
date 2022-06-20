vim.cmd "silent! command! NvChadUpdate lua require('nvchad').update_nvchad()"

local autocmd = vim.api.nvim_create_autocmd

-- Disable statusline in dashboard
autocmd("FileType", {
   pattern = "alpha",
   callback = function()
      vim.opt.laststatus = 0
   end,
})

autocmd("BufUnload", {
   buffer = 0,
   callback = function()
      vim.opt.laststatus = 3
   end,
})

-- Don't auto commenting new lines
autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o'
})

vim.cmd [[
    " map Q, W and X to quit, write and write+quit vim
    :command Q q
    :command W w
    :command X x

    " map s, x and c keys to not yank when used
    nnoremap s "_s
    vnoremap s "_s

    nnoremap x "_x
    vnoremap x "_x

    nnoremap c "_c
    vnoremap c "_c

    " prevent ci (change in ...) from yaking the selection
    nnoremap ci "_ci

    nmap i a

    " Shortcut for replace command
    nnoremap S :%s///gc<Left><Left><Left><Left>

    " Move selected lines with CTRL up and down
    xnoremap <C-Up> :move '<-2<CR>gv-gv
    xnoremap <C-Down> :move '>+1<CR>gv-gv

    noremap <C-BS> <C-w>
    noremap <C-h> <C-w>

    " Minimal number of screen lines to keep above and below the cursor.
    set scrolloff=5

]]
