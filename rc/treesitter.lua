local treesitter = require('nvim-treesitter')

treesitter.setup({ install_dir = vim.fn.stdpath('data') .. '/site' })

local function start_highlighting(buf)
  if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= '' then
    -- Filetypes without an installed parser keep Vim's syntax highlighting.
    if vim.treesitter.get_parser(buf) then
      vim.treesitter.start(buf)
    end
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('TreesitterHighlight', { clear = true }),
  callback = function(event)
    start_highlighting(event.buf)
  end,
})

local function start_loaded_buffers()
  -- VimEnter runs after the initial buffer's FileType event.
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    start_highlighting(buf)
  end
end

start_loaded_buffers()
treesitter.install({ 'python', 'markdown', 'markdown_inline' }):await(vim.schedule_wrap(function(err)
  if err then
    error(err)
  end
  start_loaded_buffers()
end))
