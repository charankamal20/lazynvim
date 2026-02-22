return {
  {
    "panghu-huang/theme-picker.nvim",
    lazy = false,
    config = function()
      require("theme-picker").setup({
        picker = {
          prompt_title = "Select Theme",
          layout_config = {
            width = 0.35,
            height = 0.5,
          },
        },
        themes = {
          { name = "Catppuccin", colorscheme = "catppuccin" },
          { name = "OneDark", colorscheme = "onedark" },
          { name = "OneLight", colorscheme = "onelight" },
          { name = "OneDark Vivid", colorscheme = "onedark_vivid" },
          { name = "OneDark Dark", colorscheme = "onedark_dark" },
          { name = "OneDark Vaporwave", colorscheme = "vaporwave" },
          { name = "Vague", colorscheme = "vague" },
          { name = "Zenwritten", colorscheme = "zenwritten" },
          { name = "Neobones", colorscheme = "neobones" },
          { name = "Vimbones", colorscheme = "vimbones" },
          { name = "Rosebones", colorscheme = "rosebones" },
          { name = "Forestbones", colorscheme = "forestbones" },
          { name = "Nordbones", colorscheme = "nordbones" },
          { name = "Tokyobones", colorscheme = "tokyobones" },
          { name = "Seoulbones", colorscheme = "seoulbones" },
          { name = "Duckbones", colorscheme = "duckbones" },
          { name = "Zenburned", colorscheme = "zenburned" },
          { name = "Kanagawabones", colorscheme = "kanagawabones" },
          { name = "Knightingale", colorscheme = "nightingale" },
          { name = "NightGem", colorscheme = "nightgem" },
          { name = "OxoCarbon", colorscheme = "oxocarbon" },

          -- Lackluster variants
          { name = "Lackluster", colorscheme = "lackluster" },
          { name = "Lackluster Hack", colorscheme = "lackluster-hack" },
          { name = "Lackluster Mint", colorscheme = "lackluster-mint" },
          { name = "Lackluster Night", colorscheme = "lackluster-night" },
          { name = "Lackluster Dark", colorscheme = "lackluster-dark" },

          -- GitHub themes
          { name = "GitHub Dark", colorscheme = "github_dark" },
          { name = "GitHub Light", colorscheme = "github_light" },
          { name = "GitHub Dark Dimmed", colorscheme = "github_dark_dimmed" },
          { name = "GitHub Dark Default", colorscheme = "github_dark_default" },
          { name = "GitHub Light Default", colorscheme = "github_light_default" },
          { name = "GitHub Dark High Contrast", colorscheme = "github_dark_high_contrast" },
          { name = "GitHub Light High Contrast", colorscheme = "github_light_high_contrast" },
          { name = "GitHub Dark Colorblind", colorscheme = "github_dark_colorblind" },
          { name = "GitHub Light Colorblind", colorscheme = "github_light_colorblind" },
          { name = "GitHub Dark Tritanopia", colorscheme = "github_dark_tritanopia" },
          { name = "GitHub Light Tritanopia", colorscheme = "github_light_tritanopia" },
        },
      })

      vim.api.nvim_set_keymap(
        "n",
        "<leader>tp",
        ':lua require("theme-picker").open_theme_picker()<CR>',
        { noremap = true, silent = true }
      )
    end,
  },
}

