-- PHP/Laravel language support
-- ~/.config/nvim/lua/plugins/lang/php.lua

return {
  -- PHP treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "php", "phpdoc" })
      end
    end,
  },

  -- Laravel.nvim - Laravel development tools
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    keys = {
      { "<leader>la", ":Laravel artisan<cr>", desc = "Laravel Artisan" },
      { "<leader>lr", ":Laravel routes<cr>", desc = "Laravel Routes" },
      { "<leader>lm", ":Laravel related<cr>", desc = "Laravel Related" },
    },
    event = { "VeryLazy" },
    opts = {
      lsp_server = "intelephense",
      features = {
        null_ls = {
          enable = false, -- Using conform.nvim instead
        },
        route_info = {
          enable = true,
          position = "right",
        },
      },
    },
    config = true,
  },

  -- PHP Refactoring Tools
  {
    "phpactor/phpactor",
    ft = "php",
    build = "composer install --no-dev -o",
    keys = {
      { "<leader>pm", ":PhpactorContextMenu<CR>", desc = "Phpactor Menu" },
      { "<leader>pn", ":PhpactorClassNew<CR>", desc = "New Class" },
      { "<leader>pe", ":PhpactorExtractExpression<CR>", desc = "Extract Expression", mode = "v" },
      { "<leader>pc", ":PhpactorExtractConstant<CR>", desc = "Extract Constant" },
      { "<leader>pi", ":PhpactorImportClass<CR>", desc = "Import Class" },
    },
  },

  -- Blade support
  {
    "jwalton512/vim-blade",
    ft = "blade",
  },

  -- Better PHP syntax
  {
    "StanAngeloff/php.vim",
    ft = "php",
  },

  -- PHP namespace resolver
  {
    "jessarcher/php-namespace-resolver.nvim",
    ft = "php",
    config = function()
      vim.keymap.set("n", "<leader>pu", function()
        vim.cmd("PhpNamespaceInsert")
      end, { desc = "Insert use statement" })
      vim.keymap.set("n", "<leader>ps", function()
        vim.cmd("PhpSortNamespace")
      end, { desc = "Sort use statements" })
    end,
  },

  -- Testing with Pest/PHPUnit
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "V13Axel/neotest-pest",
    },
    opts = {
      adapters = {
        ["neotest-pest"] = {
          pest_cmd = function()
            return "vendor/bin/pest"
          end,
        },
      },
    },
  },
}
