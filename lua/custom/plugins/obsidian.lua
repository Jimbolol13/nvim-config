return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  opts = {
    legacy_commands = false,

    workspaces = {
      {
        name = "personal",
        path = "C:\\Users\\Jimbo\\Documents\\Obsidian Vault",
      },
      {
        name = "work",
        path = "~/vaults/work",
      },
    },

    -- ✅ NEW way (no more warning)
    frontmatter = {
      func = function(note)
        return {}
      end,
    },

    -- optional: keep filenames clean
    note_id_func = function(title)
      return title
    end,

    -- optional: disable UI clutter
    footer = {
      enabled = false,
      },
    },
}
