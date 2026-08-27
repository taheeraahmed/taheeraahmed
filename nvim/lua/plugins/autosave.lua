return {
  -- Auto-save, like VSCode's "afterDelay" autosave setting
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enabled = true,
        trigger_events = { "InsertLeave", "TextChanged" },
        debounce_delay = 1000, -- save 1s after you stop typing
        condition = function(buf)
          -- Don't try to autosave unnamed/scratch buffers or special buffer types
          if vim.fn.getbufvar(buf, "&modifiable") == 1 and vim.api.nvim_buf_get_name(buf) ~= "" then
            return true
          end
          return false
        end,
      })
    end,
  },
}
