return {
  -- Format on save (like VSCode's "Format Document" on save)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          json = { "prettierd", "prettier", stop_after_first = true },
          lua = { "stylua" },
          markdown = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = {
          timeout_ms = 1000,
          lsp_fallback = true,
        },
      })
    end,
  },

  -- Git gutter signs, blame, hunk staging (like VSCode's git decorations)
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true, -- shows inline blame like VSCode's GitLens-lite
      })
    end,
  },

  -- Autopairs: auto-close brackets/quotes
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Comment toggling with Ctrl+/ like VSCode
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({})
    end,
  },

  -- Integrated terminal (like VSCode's Ctrl+`)
  -- Use :ToggleTerm to open it; no keymap is bound by default.
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "horizontal",
        size = 15,
      })
    end,
  },
}
