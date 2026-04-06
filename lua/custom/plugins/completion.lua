
return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
    },
    opts = {
      keymap = {
        preset = 'super-tab',
      },
      snippets = {
        preset = 'luasnip',
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = {
          auto_show = false,
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
      },
    },
    opts_extend = { 'sources.default' },
  },
}
