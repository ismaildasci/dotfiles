-- TypeScript/JavaScript language support
-- ~/.config/nvim/lua/plugins/lang/typescript.lua

return {
  -- TypeScript treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "javascript",
          "typescript",
          "tsx",
          "vue",
        })
      end
    end,
  },

  -- TypeScript tools
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    opts = {
      settings = {
        -- Separate diagnostic options for JS and TS
        separate_diagnostic_server = true,
        -- Code lens
        code_lens = "off",
        -- Tsserver plugins
        tsserver_plugins = {},
        -- Format options
        tsserver_format_options = {},
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
    keys = {
      { "<leader>co", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize Imports" },
      { "<leader>cO", "<cmd>TSToolsSortImports<cr>", desc = "Sort Imports" },
      { "<leader>cu", "<cmd>TSToolsRemoveUnused<cr>", desc = "Remove Unused" },
      { "<leader>cR", "<cmd>TSToolsRenameFile<cr>", desc = "Rename File" },
      { "<leader>cF", "<cmd>TSToolsFixAll<cr>", desc = "Fix All" },
      { "<leader>cM", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add Missing Imports" },
    },
  },

  -- Vue support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          filetypes = { "vue" },
        },
      },
    },
  },

  -- Package info (show latest versions in package.json)
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    opts = {
      colors = {
        up_to_date = "#3C4048",
        outdated = "#d19a66",
      },
      icons = {
        enable = true,
        style = {
          up_to_date = "|  ",
          outdated = "|  ",
        },
      },
      autostart = true,
      hide_up_to_date = false,
      hide_unstable_versions = false,
    },
    keys = {
      { "<leader>ns", "<cmd>lua require('package-info').show()<cr>", desc = "Show package versions" },
      { "<leader>nc", "<cmd>lua require('package-info').hide()<cr>", desc = "Hide package versions" },
      { "<leader>nu", "<cmd>lua require('package-info').update()<cr>", desc = "Update package" },
      { "<leader>nd", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete package" },
      { "<leader>ni", "<cmd>lua require('package-info').install()<cr>", desc = "Install package" },
      { "<leader>np", "<cmd>lua require('package-info').change_version()<cr>", desc = "Change version" },
    },
  },

  -- Testing with Vitest
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {},
      },
    },
  },
}
