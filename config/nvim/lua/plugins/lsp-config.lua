return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")

      -- Setup lua_ls with globals and Neovim runtime
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },  -- tell Lua LS that `vim` is OK :contentReference[oaicite:1]{index=1}
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),  -- include Neovim runtime :contentReference[oaicite:2]{index=2}
              checkThirdParty = false,
            },
            runtime = {
              version = "LuaJIT",
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Other servers
      lspconfig.tsserver.setup({ capabilities = capabilities })
      lspconfig.solargraph.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })

      -- Common keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
