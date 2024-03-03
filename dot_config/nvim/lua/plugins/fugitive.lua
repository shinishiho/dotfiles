return {
    "tpope/vim-fugitive",
    keys = {
        {
            "<leader>gs",
            function()
                vim.cmd.Git()
            end,
            desc = "Git Status",
        },
        {
            "<leader>gc",
            function()
                vim.cmd.Git('commit')
            end,
            desc = "Git Commit",
        },
        {
            "<leader>p",
            function()
                vim.cmd.Git('push')
            end,
            desc = "Git Push",
        },
        {
            "<leader>P",
            function()
                vim.cmd.Git({'pull',  '--rebase'})
            end,
            desc = "Git Pull",
        },
        {
            "<leader>t",
            ":Git push -u origin ",
            desc = "Git Push with tracking",
        },
    },
}
