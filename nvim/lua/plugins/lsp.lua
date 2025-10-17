local config = function()
  local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
      if desc then desc = "LSP: " .. desc end
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>r", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>a", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format current buffer with LSP" })
    end
  end

  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig_util = require("lspconfig.util")

  local servers = {}

  local installed_servers = vim.tbl_keys(servers)
  table.insert(installed_servers, "lua_ls")

  mason_lspconfig.setup({
    ensure_installed = installed_servers,
    handlers = {
      ["lua_ls"] = function()
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                library = require("neodev").library(),
              },
              telemetry = { enable = false },
              runtime = {
                version = "LuaJIT",
              },
            },
          },
          root_dir = lspconfig_util.root_pattern(".git"),
        }
        lspconfig["lua_ls"].setup(opts)
      end,

      ["*"] = function(server_name)
        local opts = servers[server_name] or {}

        local merged_opts = vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = lspconfig_util.root_pattern(".git"),
        }, opts)

        lspconfig[server_name].setup(merged_opts)
      end,
    },
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
