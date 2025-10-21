return {
  "stevearc/conform.nvim",
  opts = {
    timeout_ms = 500,
    lsp_fallback = true,
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      typescript = { "biome", "prettierd", "prettier" },
      typescriptreact = { "biome", "eslintd", "eslint", "prettierd", "prettier" },
      json = { "fixjson", "prettier" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    stop_after_first = true,
  },
}
