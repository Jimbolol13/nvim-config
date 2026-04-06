return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      default_file_explorer = true,
      columns = {},
      keymaps = {
        ['<C-h>'] = false,
        ['<C-j>'] = false,
        ['<C-k>'] = false,
        ['<C-l>'] = false,
        ['<C-c>'] = false,
        ['<M-h>'] = 'actions.select_split',
        ['q'] = 'actions.close',
      },
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = true,
    }

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    vim.keymap.set('n', '<leader>-', require('oil').toggle_float, { desc = 'Open Oil float' })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'oil',
      callback = function(event)
        vim.opt_local.cursorline = true

        local opts = { buffer = event.buf, silent = true, nowait = true }

        vim.keymap.set('n', '<C-h>', function()
          vim.cmd('wincmd h')
        end, opts)

        vim.keymap.set('n', '<C-j>', function()
          vim.cmd('wincmd j')
        end, opts)

        vim.keymap.set('n', '<C-k>', function()
          vim.cmd('wincmd k')
        end, opts)

        vim.keymap.set('n', '<C-l>', function()
          vim.cmd('wincmd l')
        end, opts)
      end,
    })
  end,
}
