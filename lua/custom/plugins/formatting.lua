return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require('null-ls')

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            disabled_filetypes = { 'markdown' },
          }),

          null_ls.builtins.formatting.stylua,
        },

        -- format on save
        on_attach = function(client, bufnr)
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              callback = function()
                local view = vim.fn.winsaveview()

                vim.lsp.buf.format({
                  bufnr = bufnr,
                  timeout_ms = 2000,
                  filter = function(client)
                    return client.name == 'null-ls'
                  end,
                })

                vim.fn.winrestview(view)
              end,
            })
          end
        end,
      })
    end,
  },
}
