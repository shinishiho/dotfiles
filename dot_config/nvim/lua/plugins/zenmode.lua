return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            width = 80,
            options = {
                signcolumn = "no",
                number = true,
                relativenumber = true,
                foldcolumn = "0",
                list = false,
                colorcolumn = "0",
            }
        },
        plugins = {
            options = {
                enabled = true,
                ruler = false,
                showcmd = false,
                laststatus = 0,
            },
            tmux = {
                enabled = true,
            },
            kitty = {
                enabled = true,
                font = "+4",
            },
        },
    },
    keys = {
        {
            "<leader>zz",
            function()
                require("zen-mode").toggle({})
            end,
            desc = "Toggle zen mode with settings for coding",
        },
        {
            "<leader>Zz",
            function()
                require("zen-mode").toggle({
                    window = {
                        width = 100,
                    },
                    plugins = {
                        kitty = {
                            font = "+2",
                        },
                    },
                })
            end,
            desc = "Toggle zen mode with settings for writing",
        },
    },
}
