-- git-signs.lua
return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 500,
        },
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Custom: get commit hash from blame, open in diffview
          local function goto_line_commit()
            local file = vim.api.nvim_buf_get_name(0)
            local line = vim.fn.line(".")
            local result = vim.fn.system(
              string.format(
                "git blame -L %d,%d --porcelain -- %s",
                line, line, vim.fn.shellescape(file)
              )
            )
            local hash = result:match("^(%x+)")
            if hash and #hash == 40 and hash ~= string.rep("0", 40) then
              vim.cmd("DiffviewOpen " .. hash .. "^!")
            else
              vim.notify(
                "No commit found (untracked or not yet committed)",
                vim.log.levels.WARN
              )
            end
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "Next hunk" })

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Prev hunk" })

          -- Hunk actions
          map("n", "gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
          map("n", "gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
          map("v", "gs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage hunk (visual)" })
          map("v", "gr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset hunk (visual)" })

          map("n", "gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
          map("n", "gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
          map("n", "gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
          map("n", "gi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

          -- Blame
          map("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "Toggle inline blame" })
          map("n", "gB", function()
            gitsigns.blame_line({ full = true })
          end, { desc = "Blame line popup (full)" })

          -- NEW: jump to the commit that last changed this line
          map("n", "gC", goto_line_commit, { desc = "Go to commit for this line" })

          -- Diff
          map("n", "gd", gitsigns.diffthis, { desc = "Diff this (index)" })
          map("n", "gD", function()
            gitsigns.diffthis("~")
          end, { desc = "Diff this (HEAD~)" })

          -- NEW: toggle diff modes
          map("n", "gtd", gitsigns.toggle_deleted, { desc = "Toggle show deleted" })
          map("n", "gtw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

          -- Quickfix
          map("n", "gQ", function()
            gitsigns.setqflist("all")
          end, { desc = "All hunks → quickfix" })
          map("n", "hq", gitsigns.setqflist, { desc = "Buffer hunks → quickfix" })

          -- Text object
          map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" })
        end,
      })
    end,
  },

  -- Required for gC (goto commit) to work
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>go", "<cmd>DiffviewOpen<cr>",          desc = "Open diffview" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>",         desc = "Close diffview" },
    },
  },

  -- NEW: permalink / open in browser
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("gitlinker").setup()
    end,
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>",  mode = { "n", "v" }, desc = "Copy git permalink" },
      { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git permalink in browser" },
    },
  },
}
