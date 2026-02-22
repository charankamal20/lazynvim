-- which-key.lua
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,
      icons = { mappings = true },
      win = { border = "rounded" },
      spec = {

        -- ── Group Labels ──────────────────────────────────────────────────
        -- Fix group labels (add <leader> prefix)
        { "<leader>e", group = "Explorer" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>gs", group = "Go struct tags" },
        { "<leader>l", group = "LSP" },
        { "<leader>n", group = "Neovim" },
        { "<leader>nt", group = "Tips" },
        { "<leader>t", group = "Terminal" },

        { "g", group = "Git hunks / Go" },
        { "gt", group = "Git toggles" },

        -- ── Explorer (neotree) ────────────────────────────────────────────
        { "<leader>e", desc = "Toggle file tree" },
        { "<leader>ee", desc = "Focus file tree" }, -- remap from <leader>i

        -- ── Find (Telescope + multigrep) ──────────────────────────────────
        { "<C-p>", desc = "Find files" },
        { "<leader><leader>", desc = "Find files (alt)" },
        { "<leader>fw", desc = "Live grep" },
        { "<leader>fg", desc = "Multi grep" },
        { "<leader>fh", desc = "Help tags" },
        { "<leader>bn", desc = "Browse nvim config" },

        -- ── LSP ───────────────────────────────────────────────────────────
        -- Apply suggested remaps: update lsp-config.lua + none-ls.lua + telescope.lua
        { "K", desc = "Hover docs" },
        { "<leader>ld", desc = "Definition" },                   -- was <leader>gd
        { "<leader>lr", desc = "References" },                   -- was <leader>gr
        { "<leader>la", desc = "Code action" },                  -- was <leader>ca
        { "<leader>lf", desc = "Format buffer" },                -- was <leader>gf (conflict fix)
        { "<leader>lF", desc = "Format selection", mode = "v" }, -- was <leader>gF
        { "<leader>ls", desc = "Document symbols" },             -- was <leader>fd
        { "<leader>lS", desc = "Workspace symbols" },            -- was <leader>fD

        { "<leader>lD", desc = "Declaration" },
        { "<leader>li", desc = "Implementation" },
        { "<leader>lt", desc = "Type definition" },
        { "<leader>ls", desc = "Signature help" },
        { "<leader>ln", desc = "Rename symbol" },
        { "<leader>lh", desc = "Toggle inlay hints" },
        { "<leader>lq", desc = "Diagnostics → loclist" },
        { "<leader>ll", desc = "Run codelens" },
        { "gl", desc = "Show diagnostic float" },
        { "[d", desc = "Prev diagnostic" },
        { "]d", desc = "Next diagnostic" },

        -- ── Git: Gitsigns (buffer-local) ───────────────────────────────────
        { "]c", desc = "Next hunk" },
        { "[c", desc = "Prev hunk" },
        { "gs", desc = "Stage hunk" },
        { "gS", desc = "Stage buffer" },
        { "gr", desc = "Reset hunk" },
        { "gR", desc = "Reset buffer" },
        { "gp", desc = "Preview hunk" },
        { "gi", desc = "Preview hunk inline" },
        { "gB", desc = "Blame line popup (full)" },
        { "gC", desc = "Go to commit for line" },
        { "gd", desc = "Diff this (index)" },
        { "gD", desc = "Diff this (HEAD~)" },
        { "gQ", desc = "All hunks → quickfix" },
        { "hq", desc = "Buffer hunks → quickfix" },
        { "ih", desc = "Select hunk", mode = { "o", "x" } },

        -- ── Git: Toggles ──────────────────────────────────────────────────
        { "gtd", desc = "Toggle show deleted" },
        { "gtw", desc = "Toggle word diff" },

        -- ── Git: Navigation / Diffview / Permalink ─────────────────────────
        -- `gb` moved here from gitsigns to fix conflict with comment.nvim
        { "<leader>gb", desc = "Toggle inline blame" }, -- was gb (conflict fix)
        { "<leader>gf", desc = "File git history" },
        { "<leader>go", desc = "Open diffview" },
        { "<leader>gc", desc = "Close diffview" },
        { "<leader>gy", desc = "Copy permalink", mode = { "n", "v" } },
        { "<leader>gY", desc = "Open permalink in browser", mode = { "n", "v" } },

        -- ── Git: Go / Gopher ──────────────────────────────────────────────
        { "<leader>gsj", desc = "Add JSON struct tags" },
        { "<leader>gsy", desc = "Add YAML struct tags" },
        { "<leader>rr", desc = "Go: if err snippet" },
        { "<leader>cm", desc = "Go: comment" },

        -- ── Terminal (toggleterm + scooter) ───────────────────────────────
        -- <leader>tt removed (was redundant duplicate of <leader>tf)
        { "<C-\\>", desc = "Toggle terminal" },
        { "<leader>tf", desc = "Float terminal" },
        { "<leader>th", desc = "Horizontal terminal" },
        { "<leader>tv", desc = "Vertical terminal" },
        { "<leader>td", desc = "Terminal in file dir" },
        { "<leader>lg", desc = "Lazygit" },
        { "<C-f>", desc = "Scooter: search" },
        { "<leader>cr", desc = "Scooter: search selection", mode = "v" },

        -- ── Neovim Tips ───────────────────────────────────────────────────
        { "<leader>nto", desc = "Open tips" },
        { "<leader>nte", desc = "Edit tips" },
        { "<leader>nta", desc = "Add tip" },
        { "<leader>nth", desc = "Tips help" },
        { "<leader>ntr", desc = "Random tip" },
        { "<leader>ntp", desc = "Tips PDF" },

        -- ── Theme ─────────────────────────────────────────────────────────
        { "<leader>tp", desc = "Theme picker" },

        -- ── Comments (comment.nvim) ───────────────────────────────────────
        { "gcc", desc = "Toggle line comment" },
        { "gbc", desc = "Toggle block comment" },
        { "gcO", desc = "Add comment above" },
        { "gco", desc = "Add comment below" },
        { "gcA", desc = "Add comment at EOL" },

        -- ── Flash ─────────────────────────────────────────────────────────
        { "s", desc = "Flash jump", mode = { "n", "x", "o" } },
        { "S", desc = "Flash treesitter", mode = { "n", "x", "o" } },
        { "r", desc = "Remote flash", mode = "o" },
        { "R", desc = "Treesitter search", mode = { "o", "x" } },
        { "<C-s>", desc = "Toggle flash search", mode = "c" },
      },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer keymaps",
      },
      {
        "<leader>K",
        function() require("which-key").show({ global = true }) end,
        desc = "All keymaps",
      },
    },
  },
}
