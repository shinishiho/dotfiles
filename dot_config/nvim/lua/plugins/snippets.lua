return {
    --{ import = "plugins.snippets.tex" },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "benfowler/telescope-luasnip.nvim",
        },

        config = function()
            local ls = require("luasnip")
            ls.config.set_config({
                enable_autosnippets = true,
            })
            require("luasnip.loaders.from_vscode").load()
            require("luasnip.loaders.from_snipmate").load()
            require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/plugins/snippets"})

            ls.filetype_extend("typescript", { "tsdoc" })
            ls.filetype_extend("javascript", { "jsdoc" })
            ls.filetype_extend("lua", { "luadoc" })
            ls.filetype_extend("python", { "pydoc" })
            ls.filetype_extend("rust", { "rustdoc" })
            ls.filetype_extend("cs", { "csharpdoc" })
            ls.filetype_extend("java", { "javadoc" })
            ls.filetype_extend("c", { "cdoc" })
            ls.filetype_extend("cpp", { "cppdoc" })
            ls.filetype_extend("php", { "phpdoc" })
            ls.filetype_extend("kotlin", { "kdoc" })
            ls.filetype_extend("ruby", { "rdoc" })
            ls.filetype_extend("sh", { "shelldoc" })
        end,
    },
}
