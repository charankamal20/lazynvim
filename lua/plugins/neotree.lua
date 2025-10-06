return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = false, 
  config = function() 
    vim.keymap.set('n',  '<leader>e', ':Neotree toggle filesystem reveal right<cr>', {}) 
    vim.keymap.set('n',  '<leader>i', ':Neotree focus<cr>', {}) 
  end 
} 
