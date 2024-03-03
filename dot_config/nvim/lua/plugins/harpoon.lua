return {
    "theprimeagen/harpoon",
    keys = {
        {
            "<leader>ha",
            function()
                require("harpoon.mark").add_file()
            end,
            desc = "Add current file to harpoon",
        },
        {
            "<leader>hs",
            function()
                require("harpoon.ui").toggle_quick_menu()
            end,
            desc = "Toggle Harpoon UI",
        },
        {
            "<leader>a",
            function()
                require("harpoon.ui").nav_file(1)
            end,
            desc = "Navigate to Harpoon file 1",
        },
        {
            "<leader>s",
            function()
                require("harpoon.ui").nav_file(2)
            end,
            desc = "Navigate to Harpoon file 2",
        },
        {
            "<leader>d",
            function()
                require("harpoon.ui").nav_file(3)
            end,
            desc = "Navigate to Harpoon file 3",
        },
        {
            "<leader>f",
            function()
                require("harpoon.ui").nav_file(4)
            end,
            desc = "Navigate to Harpoon file 4",
        },
    }
}
