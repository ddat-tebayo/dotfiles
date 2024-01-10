require('bufferline').setup {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,

    indicator = '',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
      if buf.name:match "%.md" then
        return vim.fn.fnamemodify(buf.name, ":t:r")
      end
    end,

    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 18,
    diagnostics = false,
    diagnostics_update_in_insert = false,

    offsets = {{filetype = "NvimTree", text = "File Explorer"}},
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    -- show_buffer_default_icon = true, ---default
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = { '', '' },--"padded_slant" | "thick" | "thin" |
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    --sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
      -- add custom logic
      --return buffer_a.modified > buffer_b.modified
    --end,
  },
  highlights = {
    separator = {
      fg = '#00f269',
    },
  },
}
