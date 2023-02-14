local options = {
--Function setting--
  clipboard = "unnamedplus", --allows neovim to access the system clipboard
  completeopt = {"noinsert", "menuone", "noselect"}, --mostly just for completion
  fileencoding = "utf-8", --the encoding written to a file
  undofile = true, --enable persistent undo
  swapfile = false, --creates a swapfile

  updatetime = 300, --faster completion (4000ms default)
  timeoutlen = 100, --time to wait for a mapped sequence to complete (in milliseconds)

  ignorecase = true, --ignore case in search patterns
  smartcase = true, --smart case

  splitbelow = true, --force all horizontal splits to go below current window
  splitright = true, --force all vertical splits to go to the right of current window

  
--Display setting--
  mouse = "a", --allow the mouse to be used in neovim
  showmode = false, --we don't need to see things like -- INSERT -- anymore
  wrap = false, --display lines as one long line
  hlsearch = true, --highlight all matches on previous search pattern
  signcolumn = "yes",
  inccommand = "split",
  termguicolors = true, --set term gui colors
  cmdheight = 1, --more space in the neovim command line for displaying messages (default 1)

  expandtab = true, --convert tabs to spaces
  shiftwidth = 2, --the number of spaces inserted for each indentation
  tabstop = 2, --insert 2 spaces for a tab
    --set numbered lines, ralative numbered lines
  number = true,
  relativenumber = true,
    --keep the cursor to the center of screen, default is first line/last line
  scrolloff = 8,          
  sidescrolloff = 8,
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]
