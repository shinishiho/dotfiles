local plugins = {

  {
    "theprimeagen/harpoon",
    keys = {
      "<leader>a",
      "<leader>j"

    },
    config = function ()
      require("harpoon"):setup()
      require("core.utils").load_mappings "harpoon.ui"
    end,
    lazy = false
  },
  {
    "mbbill/undotree",
    keys = { "<leader>tu" },
    -- cmd = { "UndotreeToggle" },
    config = function()
      require("core.utils").load_mappings "undotree"
    end,
    lazy = false
  },
}

return plugins
