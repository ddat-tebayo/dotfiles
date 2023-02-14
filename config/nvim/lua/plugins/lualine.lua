local lualine = require('lualine')

local hide_in_width_58 = function()
	return vim.fn.winwidth(0) > 58
end
local hide_in_width_46 = function()
	return vim.fn.winwidth(0) > 46
end


local encoding = {
  "encoding",
  cond = hide_in_width_46
}
local filetype = {
  "filetype",
  cond = hide_in_width_46
}
local filename = {
  "filename",
  cond = hide_in_width_58
}

local colors = {
  green = '#608c4d',
  blue = '#559dd7',
  purple = '#c687c1',
  red = '#d26969',
  black = '#1a1c23',
  light_grey = '#2e303e',
  grey = '#5c5f7e',
  white = '#eeeeee'
}

local my_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.green },
    b = { fg = colors.green, bg = colors.light_grey },
    c = { fg = colors.grey, bg = colors.black },
  },

  insert = {
    a = { fg = colors.black, bg = colors.blue }, b = { fg = colors.blue, bg = colors.light_grey },
  },
  visual = {
    a = { fg = colors.black, bg = colors.purple }, b = { fg = colors.purple, bg = colors.light_grey },
  },
  replace = {
    a = { fg = colors.black, bg = colors.red }, b = { fg = colors.red, bg = colors.light_grey },
  },
  command = {
    a = { fg = colors.black, bg = colors.white }, b = { fg = colors.white, bg = colors.light_grey },
  },

  inactive = {
    a = { fg = colors.grey, bg = colors.black },
    b = { fg = colors.grey, bg = colors.black },
    c = { fg = colors.grey, bg = colors.black },
  },
}

local diff = {
	"diff",
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols 
  cond = hide_in_width_46
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = true,
	update_in_insert = false,
	always_visible = true,
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = my_theme,
    component_separators = { left = '', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {diagnostics},
    lualine_c = {filename},
    lualine_x = {'branch', diff},
    lualine_y = {encoding, filetype},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
