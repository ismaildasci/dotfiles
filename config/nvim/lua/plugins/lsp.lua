-- LSP configuration
-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  -- LSP config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- PHP - Intelephense (primary)
        intelephense = {
          settings = {
            intelephense = {
              stubs = {
                "apache",
                "bcmath",
                "bz2",
                "calendar",
                "com_dotnet",
                "Core",
                "ctype",
                "curl",
                "date",
                "dba",
                "dom",
                "enchant",
                "exif",
                "FFI",
                "fileinfo",
                "filter",
                "fpm",
                "ftp",
                "gd",
                "gettext",
                "gmp",
                "hash",
                "iconv",
                "imap",
                "intl",
                "json",
                "ldap",
                "libxml",
                "mbstring",
                "meta",
                "mysqli",
                "oci8",
                "odbc",
                "openssl",
                "pcntl",
                "pcre",
                "PDO",
                "pdo_ibm",
                "pdo_mysql",
                "pdo_pgsql",
                "pdo_sqlite",
                "pgsql",
                "Phar",
                "posix",
                "pspell",
                "random",
                "readline",
                "Reflection",
                "session",
                "shmop",
                "SimpleXML",
                "snmp",
                "soap",
                "sockets",
                "sodium",
                "SPL",
                "sqlite3",
                "standard",
                "superglobals",
                "sysvmsg",
                "sysvsem",
                "sysvshm",
                "tidy",
                "tokenizer",
                "xml",
                "xmlreader",
                "xmlrpc",
                "xmlwriter",
                "xsl",
                "Zend OPcache",
                "zip",
                "zlib",
                -- Laravel stubs
                "redis",
              },
              files = {
                maxSize = 5000000,
              },
              environment = {
                includePaths = {
                  -- Add Laravel facade helpers
                },
              },
              telemetry = {
                enabled = false,
              },
            },
          },
        },
        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              completion = { callSnippet = "Replace" },
              telemetry = { enable = false },
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        -- HTML
        html = {},
        -- CSS
        cssls = {},
        -- Emmet
        emmet_ls = {
          filetypes = { "html", "css", "php", "blade", "vue", "javascriptreact", "typescriptreact" },
        },
        -- YAML
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        -- Tailwind CSS
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "php",
            "blade",
            "vue",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
          settings = {
            tailwindCSS = {
              classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
              lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
              },
              validate = true,
            },
          },
        },
      },
    },
  },

  -- Mason - LSP installer
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- PHP
        "intelephense",
        "php-cs-fixer",
        "phpstan",
        "pint",
        -- JavaScript/TypeScript
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
        -- HTML/CSS
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "emmet-ls",
        -- Lua
        "lua-language-server",
        "stylua",
        -- YAML/JSON
        "yaml-language-server",
        "json-lsp",
        -- Shell
        "shfmt",
        "shellcheck",
      },
    },
  },

  -- Formatting with conform.nvim
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "pint", "php_cs_fixer" },
        blade = { "blade-formatter" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        sh = { "shfmt" },
      },
      formatters = {
        pint = {
          command = "pint",
          args = { "$FILENAME" },
          stdin = false,
        },
      },
    },
  },

  -- Linting with nvim-lint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        php = { "phpstan" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
      },
    },
  },
}
