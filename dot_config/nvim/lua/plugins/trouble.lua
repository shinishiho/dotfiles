return {
    "folke/trouble.nvim",
    opts = {
        icon = false,
    },

    keys = {
        {
            "<leader>tt",
            function()
                require("trouble").toggle("workspace_diagnostics")
            end,
            desc = "Toggle trouble",
        },
        {
            "<leader>tn",
            function()
                require("trouble").next({ skip_group = true, jump = true })
            end,
            desc = "Jump to next error",
        },
        {
            "<leader>tp",
            function()
                require("trouble").previous({ skip_group = true, jump = true })
            end,
            desc = "Jump to previous error",
        },
    },
}
