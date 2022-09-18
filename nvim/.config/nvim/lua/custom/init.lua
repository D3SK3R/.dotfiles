-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"

-- commands
vim.cmd "silent! command! NvChadUpdate lua require('nvchad').update_nvchad()"
vim.cmd "silent! command! NvChadSnapshotCreate lua require('nvchad').snap_create()"
vim.cmd "silent! command! NvChadSnapshotDelete lua require('nvchad').snap_delete()"
vim.cmd "silent! command! NvChadSnapshotCheckout lua require('nvchad').snap_checkout()"

-- autocmds
local autocmd = vim.api.nvim_create_autocmd
local api = vim.api

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- wrap the PackerSync command to warn people before using it in NvChadSnapshots
autocmd("VimEnter", {
  callback = function()
    vim.cmd "command! -nargs=* -complete=customlist,v:lua.require'packer'.plugin_complete PackerSync lua require('plugins') require('core.utils').packer_sync(<f-args>)"
  end,
})

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
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- store listed buffers in tab local var
vim.t.bufs = vim.api.nvim_list_bufs()

-- autocmds for tabufline -> store bufnrs on bufadd, bufenter events
-- thx to https://github.com/ii14 & stores buffer per tab -> table
autocmd({ "BufAdd", "BufEnter" }, {
  callback = function(args)
    if vim.t.bufs == nil then
      vim.t.bufs = { args.buf }
    else
      local bufs = vim.t.bufs

      -- check for duplicates
      if not vim.tbl_contains(bufs, args.buf) and (args.event == "BufAdd" or vim.bo[args.buf].buflisted) then
        table.insert(bufs, args.buf)
        vim.t.bufs = bufs
      end
    end
  end,
})

autocmd("BufDelete", {
  callback = function(args)
    for _, tab in ipairs(api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufs
      if bufs then
        for i, bufnr in ipairs(bufs) do
          if bufnr == args.buf then
            table.remove(bufs, i)
            vim.t[tab].bufs = bufs
            break
          end
        end
      end
    end
  end,
})

vim.cmd [[
    " prevent nvim from changing terminal title
    set notitle

    " map Q, W and X to quit, write and write+quit vim
    :command Q q
    :command W w
    :command X x

    " map s, x and c keys to not yank when used
    nnoremap s "_s
    vnoremap s "_s

    nnoremap x "_x
    vnoremap x "_x

    nnoremap p Pgvy
    vnoremap p Pgvy

    nnoremap c "_c
    vnoremap c "_c

    " prevent ci (change in ...) from yaking the selection
    nnoremap ci "_ci

    nmap a i

    " Shortcut for replace command
    nnoremap S :%s///gc<Left><Left><Left><Left>

    " Move selected lines with CTRL up and down
    xnoremap <C-Up> :move '<-2<CR>gv-gv
    xnoremap <C-Down> :move '>+1<CR>gv-gv

    " make ctrl+backspace act as ctrl w
    " for some RANDOM reason, it doens't automatically work, but running :inoremap <C-H> <C-w> works!
    inoremap <C-H> <C-w>
    inoremap <M-BS> <C-w>
    " that runs the command so that it works.
    autocmd BufRead * inoremap <C-H> <C-w>

    " Minimal number of screen lines to keep above and below the cursor.
    set scrolloff=5

    "Automatically run xrdb /.Xresouces when the file is changed
    autocmd BufWritePost .Xresources !xrdb %

    "Set default nvim cursor to a horizontal line 
    set guicursor=a:hor2-blinkon0

    "Set a horizontal cursor back again when nvim leaves
    au VimLeave * set guicursor=a:hor2-blinkon0

    autocmd BufRead */*rc set syntax=dosini
    
    " type :w!! to save the file as root when it says you have no permission to write
    " for this to work, install ksshaskpass
    cmap w!! w !SUDO_ASKPASS=/usr/bin/ksshaskpass sudo -A tee > /dev/null % <Enter>
    

]]

