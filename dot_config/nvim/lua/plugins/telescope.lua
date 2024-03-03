return {
    {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.5',
        lazy = true,
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                config = function()
                    require("telescope").load_extension("fzf")
                end,
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                config = function()
                    require("telescope").load_extension("frecency")
                end,
            }
        },

        keys = {
            {
                "<leader>ff",
                function()
                    require("telescope.builtin").find_files({})
                end,
                desc = "Fuzzy find files",
            },
            {
                "<leader>gf",
                function()
                    require("telescope.builtin").git_files({})
                end,
                desc = "Fuzzy find git files",
            },
            {
                "<leader>fb",
                function()
                    require("telescope.builtin").buffers({ initial_mode = "normal" })
                end,
                desc = "Fuzzy find buffers",
            },
            {
                "<leader>fs",
                function()
                    require("telescope.builtin").live_grep({})
                end,
                desc = "Fuzzy search",
            },
            {
                "<leader>fws",
                function()
                    local word = vim.fn.expand("<cword>")
                    require("telescope.builtin").grep_string({ search = word, initial_mode = "normal" })
                end,
                desc = "Fuzzy search word under cursor",
            },
            {
                "<leader>fWs",
                function()
                    local word = vim.fn.expand("<cWORD>")
                    require("telescope.builtin").grep_string({ search = word, initial_mode = "normal" })
                end,
                desc = "Fuzzy search WORD under cursor",
            },
            {
                "<leader>sos",
                function()
                    require("telescope.builtin").help_tags({})
                end,
                desc = "Search help tags",
            },
        },

        opts = {
            defaults = {
                layout_strategy = "flex",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                winblend = 0,
            },
        },
    },
}
