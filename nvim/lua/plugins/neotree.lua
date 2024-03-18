local setup = function()
  vim.keymap.set('n', '<C-t>', ':Neotree toggle<cr>', { desc = 'toggle neotree' })
  vim.keymap.set('n', '-', function()
      local reveal_file = vim.fn.expand('%:p')
      if (reveal_file == '') then
        reveal_file = vim.fn.getcwd()
      else
        local f = io.open(reveal_file, "r")
        if (f) then
          f.close(f)
        else
          reveal_file = vim.fn.getcwd()
        end
      end
      require('neo-tree.command').execute({
        action = "focus",
        source = "filesystem",
        position = "current",
        reveal_file = reveal_file,
        reveal_force_cwd = true,
      })
    end,
    { desc = "Open neo-tree at current file or working directory" }
  ); -- nnoremap <leader>s :Neotree float git_status<cr>

  require('neo-tree').setup({
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true
      },
      use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
    },
  })
end

-- nnoremap <leader>b :Neotree toggle show buffers right<cr>

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = setup,
}
