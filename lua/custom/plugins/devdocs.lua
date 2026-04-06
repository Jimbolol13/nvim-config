return {
  {
    'nvim-telescope/telescope.nvim',
    init = function()
      vim.fn.mkdir(vim.fn.stdpath('config') .. '/docs', 'p')
    end,
    keys = {
      {
        '<leader>sD',
        function()
          local base = vim.fn.stdpath('config') .. '/docs'
          local sources = {
            all = base,
            tailwind = base .. '/tailwindcss.com',
            bootstrap = base .. '/bootstrap',
            php = base .. '/php',
            symfony = base .. '/symfony-docs',
          }

          vim.ui.select(vim.tbl_keys(sources), {
            prompt = 'Search which docs?',
          }, function(choice)
            if not choice then
              return
            end

            require('telescope.builtin').live_grep({
              prompt_title = 'Search Docs: ' .. choice,
              cwd = sources[choice],
            })
          end)
        end,
        desc = '[S]earch [D]ocs content',
      },
      {
        '<leader>fD',
        function()
          local base = vim.fn.stdpath('config') .. '/docs'
          local sources = {
            all = base,
            tailwind = base .. '/tailwindcss.com',
            bootstrap = base .. '/bootstrap',
            php = base .. '/php',
            symfony = base .. '/symfony-docs',
          }

          vim.ui.select(vim.tbl_keys(sources), {
            prompt = 'Find topic in which docs?',
          }, function(choice)
            if not choice then
              return
            end

            require('telescope.builtin').find_files({
              prompt_title = 'Find Docs Topic: ' .. choice,
              cwd = sources[choice],
            })
          end)
        end,
        desc = '[F]ind [D]ocs topic/file',
      },
      {
        '<leader>gD',
        function()
          local base = vim.fn.stdpath('config') .. '/docs'
          local sources = {
            all = base,
            tailwind = base .. '/tailwindcss.com',
            bootstrap = base .. '/bootstrap',
            php = base .. '/php',
            symfony = base .. '/symfony-docs',
          }

          vim.ui.select(vim.tbl_keys(sources), {
            prompt = 'Search current word in which docs?',
          }, function(choice)
            if not choice then
              return
            end

            require('telescope.builtin').grep_string({
              prompt_title = 'Docs for "' .. vim.fn.expand('<cword>') .. '": ' .. choice,
              cwd = sources[choice],
              search = vim.fn.expand('<cword>'),
            })
          end)
        end,
        desc = '[G]rep current word in [D]ocs',
      },
    },
  },
}
