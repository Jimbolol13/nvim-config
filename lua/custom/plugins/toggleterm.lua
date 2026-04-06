return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      size = 20,
      open_mapping = [[<c-\>]],
      direction = 'float',
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      close_on_exit = false, -- keep terminal buffers alive
      shell = 'pwsh',
      float_opts = {
        border = 'rounded',
      },
    }

    vim.keymap.set('t', 'kj', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

    local Terminal = require('toggleterm.terminal').Terminal
    local terminals = {} -- per-directory terminal lists
    local current_term_index = {} -- per-directory current index for cycling

    local function get_valid_dir()
      local dir
      if vim.bo.filetype == 'oil' then
        local ok, oil = pcall(require, 'oil')
        if ok then dir = oil.get_current_dir() end
      end
      if not dir or dir == '' then dir = vim.fn.expand '%:p:h' end
      if not dir or dir == '' then dir = vim.fn.getcwd() end
      if vim.fn.isdirectory(dir) == 0 then dir = vim.fn.getcwd() end
      return dir
    end

    -- Open a new terminal in the current directory
    vim.keymap.set('n', '<leader>tt', function()
      local dir = get_valid_dir()
      if not terminals[dir] then terminals[dir] = {} end
      if not current_term_index[dir] then current_term_index[dir] = 0 end

      local term = Terminal:new {
        dir = dir,
        direction = 'float',
        close_on_exit = false,
        float_opts = { border = 'rounded' },
      }

      table.insert(terminals[dir], term)
      current_term_index[dir] = #terminals[dir] -- point to the newest terminal
      term:toggle()
    end, { desc = 'Open new terminal (Oil + file + cwd)' })

    -- Cycle through all terminals in the current directory
    vim.keymap.set('n', '<leader>TT', function()
      local dir = get_valid_dir()
      local list = terminals[dir]
      if not list or #list == 0 then
        vim.notify('No terminals in this directory!', vim.log.levels.INFO)
        return
      end

      -- Increment index, wrap around
      current_term_index[dir] = (current_term_index[dir] % #list) + 1
      local term = list[current_term_index[dir]]

      if vim.api.nvim_buf_is_valid(term.bufnr) then
        term:toggle()
      else
        table.remove(list, current_term_index[dir])
        current_term_index[dir] = 0
        vim.notify('A terminal was closed and removed!', vim.log.levels.INFO)
      end
    end, { desc = 'Cycle through terminals in current directory' })
  end,
}
