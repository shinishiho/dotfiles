local M = {}

M.harpoon = {
  plugin = true,
  n = {
    ["<leader>a"] = function ()
      require("harpoon"):list():append()
    end,
    "Add current file to harpoon"
  },
  {
    ["<leader>j"] = function ()
      require("harpoon"):list():select(1)
    end,
    "Switch to first harpoon item"
  },
  {
    ["<leader>k"] = function ()
      require("harpoon"):list():select(2)
    end,
    "Switch to second harpoon item"
  },
  {
    ["<leader>l"] = function ()
      require("harpoon"):list():select(3)
    end,
    "Switch to third harpoon item"
  },
  {
    ["<leader>;"] = function ()
      require("harpoon"):list():select(4)
    end,
    "Switch to fourth harpoon item"
  },
}
M.harpoon.ui = {
  plugin = true,
  {
    ["<C-e>"] = function ()
      require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
    end
  }

}
M.undotree = {
  plugin = true,
  n = {
    ["<leader>tu"] = {
      "<cmd>UndotreeToggle<CR>"
    }
  }
}

return M
