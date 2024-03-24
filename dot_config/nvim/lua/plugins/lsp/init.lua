return {
    { import = "plugins.lsp.copilot" },
    { import = "plugins.lsp.cmp" },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },

        config = function()
            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "tsserver",
                    "rust_analyzer",
                    "lua_ls",
                    "clangd",
                },
                handlers = {
                    function (server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                },
            })
        end
    },
}
