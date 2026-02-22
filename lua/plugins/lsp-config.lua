-- lsp-config.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()

      -- ── Mason UI ────────────────────────────────────────────────────────
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed   = "✓",
            package_pending     = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- ── Capabilities ────────────────────────────────────────────────────
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- ── Diagnostics ─────────────────────────────────────────────────────
      vim.diagnostic.config({
        severity_sort  = true,
        update_in_insert = false,
        underline      = true,
        virtual_text   = { prefix = "●", source = "if_many" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰌵 ",
          },
        },
        float = { border = "rounded", source = "always" },
      })

      -- Auto-open diagnostics on cursor hold
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
        end,
      })

      -- ── LSP Keymaps (on attach) ──────────────────────────────────────────
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true }),
        callback = function(event)
          local bufnr  = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
          end

          -- Navigation
          map("n", "K",            vim.lsp.buf.hover,           "Hover docs")
          map("n", "<leader>ld",   vim.lsp.buf.definition,      "Definition")
          map("n", "<leader>lD",   vim.lsp.buf.declaration,     "Declaration")
          map("n", "<leader>li",   vim.lsp.buf.implementation,  "Implementation")
          map("n", "<leader>lt",   vim.lsp.buf.type_definition, "Type definition")
          map("n", "<leader>lr",   vim.lsp.buf.references,      "References")
          map("n", "<leader>ls",   vim.lsp.buf.signature_help,  "Signature help")

          -- Actions
          map("n",        "<leader>la", vim.lsp.buf.code_action, "Code action")
          map("x",        "<leader>la", vim.lsp.buf.code_action, "Code action (range)")
          map("n",        "<leader>ln", vim.lsp.buf.rename,      "Rename symbol")
          map({ "n", "x" }, "<leader>lf", function()
            vim.lsp.buf.format({ async = true })
          end, "Format")

          -- Diagnostics
          map("n", "gl",          vim.diagnostic.open_float,  "Show diagnostic")
          map("n", "[d",          vim.diagnostic.goto_prev,   "Prev diagnostic")
          map("n", "]d",          vim.diagnostic.goto_next,   "Next diagnostic")
          map("n", "<leader>lq",  vim.diagnostic.setloclist,  "Diagnostics → loclist")

          -- Inlay hints toggle (Neovim 0.10+)
          if client and client.server_capabilities.inlayHintProvider then
            map("n", "<leader>lh", function()
              local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
              vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
            end, "Toggle inlay hints")
          end

          -- Code lens (if supported — e.g. gopls test/run lenses)
          if client and client.server_capabilities.codeLensProvider then
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = bufnr,
              callback = vim.lsp.codelens.refresh,
            })
            map("n", "<leader>ll", vim.lsp.codelens.run, "Run codelens")
          end
        end,
      })

      -- ── Server Setup ────────────────────────────────────────────────────
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "gopls",
          "lua_ls",
          "eslint",
          "html",
          "cssls",
          "jsonls",
        },
        handlers = {

          -- Default: setup every server with shared capabilities
          function(server)
            require("lspconfig")[server].setup({
              capabilities = capabilities,
            })
          end,

          -- ── Lua ─────────────────────────────────────────────────────────
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime     = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace   = {
                    checkThirdParty = false,
                    library = vim.api.nvim_get_runtime_file("", true),
                  },
                  completion  = { callSnippet = "Replace" },
                  hint        = { enable = true },
                  telemetry   = { enable = false },
                },
              },
            })
          end,

          -- ── Go ──────────────────────────────────────────────────────────
          ["gopls"] = function()
            require("lspconfig").gopls.setup({
              capabilities = capabilities,
              settings = {
                gopls = {
                  completeUnimported = true,
                  usePlaceholders    = true,
                  staticcheck        = true,
                  gofumpt            = true,
                  analyses = {
                    unusedparams = true,
                    shadow       = true,
                    unusedwrite  = true,
                    useany       = true,
                  },
                  -- Inlay hints (shown/hidden via <leader>lh)
                  hints = {
                    assignVariableTypes    = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes  = true,
                    constantValues         = true,
                    functionTypeParameters = true,
                    parameterNames         = true,
                    rangeVariableTypes     = true,
                  },
                  -- Code lenses: run tests, tidy, generate from editor
                  codelenses = {
                    generate   = true,
                    gc_details = true,
                    test       = true,
                    tidy       = true,
                    run_govulncheck = true,
                  },
                },
              },
            })
          end,

          -- ── TypeScript ──────────────────────────────────────────────────
          ["ts_ls"] = function()
            require("lspconfig").ts_ls.setup({
              capabilities = capabilities,
              settings = {
                typescript = {
                  inlayHints = {
                    includeInlayParameterNameHints              = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints      = true,
                    includeInlayVariableTypeHints               = true,
                    includeInlayPropertyDeclarationTypeHints    = true,
                    includeInlayFunctionLikeReturnTypeHints     = true,
                    includeInlayEnumMemberValueHints            = true,
                  },
                },
                javascript = {
                  inlayHints = {
                    includeInlayParameterNameHints              = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints      = true,
                    includeInlayVariableTypeHints               = true,
                    includeInlayPropertyDeclarationTypeHints    = true,
                    includeInlayFunctionLikeReturnTypeHints     = true,
                    includeInlayEnumMemberValueHints            = true,
                  },
                },
              },
            })
          end,

          -- ── ESLint: auto-fix on save ─────────────────────────────────────
          ["eslint"] = function()
            require("lspconfig").eslint.setup({
              capabilities = capabilities,
              on_attach = function(_, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer  = bufnr,
                  command = "EslintFixAll",
                })
              end,
            })
          end,

        },
      })
    end,
  },
}

