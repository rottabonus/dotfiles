local config = function()
  local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
      if desc then desc = "LSP: " .. desc end
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    -- LSP keymaps
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<leader>r", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>a", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format current buffer with LSP" })
    end
  end

  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig_util = require("lspconfig.util")

  -- Servers with custom settings
  local servers = {
    lua_ls = {}, -- Lua custom settings handled in handler
    vtsls = {},  -- TS/JS server
  }

  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
    handlers = {
      ["lua_ls"] = function()
        local ok, neodev = pcall(require, "neodev")
        if ok then neodev.setup() end

        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = lspconfig_util.root_pattern(".git"),
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = ok and neodev.library() or {},
              },
              telemetry = { enable = false },
            },
          },
        }

        lspconfig.lua_ls.setup(opts)
      end,

      ["*"] = function(server_name)
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = lspconfig_util.root_pattern(".git", "tsconfig.json", "package.json"),
        })
      end,
    },
  })

  -- Attach on_attach to any already running clients (like biome)
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(args)
      local bufnr = args.buf
      for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        -- only attach if not already attached
        local exists = vim.fn.mapcheck("gd", "n", bufnr)
        if exists == "" then
          on_attach(client, bufnr)
        end
      end
    end,
  })
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    {
      "folke/neodev.nvim",
      config = function()
        require("neodev").setup()
      end,
      priority = 1000,
    },
  },
  config = config,
}
