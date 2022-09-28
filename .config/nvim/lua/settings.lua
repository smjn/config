local vo = vim.opt
local vg = vim.g

-- search
vo.hlsearch = true
vo.incsearch = true
vo.ignorecase = true
vo.smartcase = true

-- indent
vo.smartindent = true
vo.expandtab = true
vo.softtabstop = 4
vo.shiftwidth = 4
vo.tabstop = 4

-- split/tab/window
vo.splitbelow = true
vo.splitright = true

-- file
vo.fileencoding = "utf-8"
vo.listchars = "eol:⏎,tab:▸·,trail:×,nbsp:⎵"

-- color
vo.termguicolors = true
-- vo.background = "dark"

-- line number
vo.relativenumber = true
vo.number = true
vo.cursorline = true

-- misc
vo.hidden = true

-- netrw
vg.netrw_banner = 0
vg.netrw_liststyle = 3
vg.netrw_browse_split = 4
vg.netrw_altv = 1
vg.netrw_winsize = 25
