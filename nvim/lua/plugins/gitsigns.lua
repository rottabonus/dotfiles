return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(bufnr)
      vim.keymap.set(
        "n",
        "[c",
        require("gitsigns").prev_hunk,
        { buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
      )
      vim.keymap.set(
        "n",
        "]c",
        require("gitsigns").next_hunk,
        { buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
      )
      vim.keymap.set(
        "n",
        "<leader>ph",
        require("gitsigns").preview_hunk,
        { buffer = bufnr, desc = "[P]review [H]unk" }
      )

      vim.keymap.set(
        "n",
        "<leader>gU",
        ":Gitsigns reset_hunk<CR>",
        { buffer = bufnr, desc = "Undo Hunk" }
      )
    end,
  },
}
