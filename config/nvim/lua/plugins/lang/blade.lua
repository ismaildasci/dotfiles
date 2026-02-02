-- Blade template language support
-- ~/.config/nvim/lua/plugins/lang/blade.lua

return {
  -- Blade treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Add blade parser
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "blade", "html", "php" })
      end
    end,
  },

  -- Blade file detection
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })
    end,
  },

  -- Blade snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function(_, opts)
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local c = ls.choice_node

      -- Blade-specific snippets
      ls.add_snippets("blade", {
        -- Directives
        s("@if", {
          t("@if ("),
          i(1, "condition"),
          t({ ")", "\t" }),
          i(2),
          t({ "", "@endif" }),
        }),
        s("@foreach", {
          t("@foreach ("),
          i(1, "$items"),
          t(" as "),
          i(2, "$item"),
          t({ ")", "\t" }),
          i(3),
          t({ "", "@endforeach" }),
        }),
        s("@forelse", {
          t("@forelse ("),
          i(1, "$items"),
          t(" as "),
          i(2, "$item"),
          t({ ")", "\t" }),
          i(3),
          t({ "", "@empty", "\t" }),
          i(4),
          t({ "", "@endforelse" }),
        }),
        s("@auth", {
          t({ "@auth", "\t" }),
          i(1),
          t({ "", "@endauth" }),
        }),
        s("@guest", {
          t({ "@guest", "\t" }),
          i(1),
          t({ "", "@endguest" }),
        }),
        s("@can", {
          t("@can('"),
          i(1, "ability"),
          t({ "')", "\t" }),
          i(2),
          t({ "", "@endcan" }),
        }),
        s("@cannot", {
          t("@cannot('"),
          i(1, "ability"),
          t({ "')", "\t" }),
          i(2),
          t({ "", "@endcannot" }),
        }),
        s("@include", {
          t("@include('"),
          i(1, "view.name"),
          t("')"),
        }),
        s("@extends", {
          t("@extends('"),
          i(1, "layouts.app"),
          t("')"),
        }),
        s("@section", {
          t("@section('"),
          i(1, "name"),
          t({ "')", "" }),
          i(2),
          t({ "", "@endsection" }),
        }),
        s("@yield", {
          t("@yield('"),
          i(1, "name"),
          t("')"),
        }),
        s("@component", {
          t("<x-"),
          i(1, "component-name"),
          t({ ">", "\t" }),
          i(2),
          t({ "", "</x-" }),
          i(3, "component-name"),
          t(">"),
        }),
        -- Livewire
        s("@livewire", {
          t("@livewire('"),
          i(1, "component-name"),
          t("')"),
        }),
        s("wire:model", {
          t('wire:model="'),
          i(1, "property"),
          t('"'),
        }),
        s("wire:click", {
          t('wire:click="'),
          i(1, "method"),
          t('"'),
        }),
      })
    end,
  },

  -- Emmet for Blade
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_ls = {
          filetypes = { "html", "css", "php", "blade", "vue" },
        },
      },
    },
  },
}
