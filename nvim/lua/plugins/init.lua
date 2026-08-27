return {
  -- Colorscheme (VSCode-like dark theme)
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- File explorer sidebar (like VSCode's file tree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        filters = {
          dotfiles = false,  -- show .env, .gitignore, etc.
          git_ignored = false, -- show files listed in .gitignore (e.g. .env is usually gitignored)
        },
      })
    end,
  },

  -- Icons used by nvim-tree and others
  { "nvim-tree/nvim-web-devicons" },

  -- Syntax highlighting (much better than default)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- stable API; avoids needing the separate tree-sitter CLI
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "javascript", "typescript", "json", "bash", "markdown", "yaml", "html", "css" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Fuzzy finder (Ctrl+P style file search, like VSCode)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Status line at the bottom (like VSCode's status bar)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({})
    end,
  },

  -- Show open buffers as tabs at the top (like VSCode tabs)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({})
    end,
  },
}
