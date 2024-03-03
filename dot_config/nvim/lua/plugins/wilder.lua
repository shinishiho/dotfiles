return {
    "gelguy/wilder.nvim",
    dependencies = {
        "romgrk/fzy-lua-native",
    },
    event = "VeryLazy",

    config = function ()
        local wilder = require("wilder")
        wilder.setup({modes = {":", "/", '?'}})
        wilder.set_option("renderer", wilder.renderer_mux({
            [":"] = wilder.popupmenu_renderer({
                highlighter = wilder.lua_fzy_highlighter(),
                highlights = {
                    accent = wilder.make_hl(
                    "WilderAccent", 'Pmenu', {{a = 1}, {a = 1},
                    {foreground = "#f7b152"}}),
                },
                left = {" ", wilder.popupmenu_devicons()},
            }),

            ["/"] = wilder.wildmenu_renderer({
                highlighter = wilder.lua_fzy_highlighter(),
                highlights = {
                    accent = wilder.make_hl(
                    "WilderAccent", 'Pmenu', {{a = 1}, {a = 1},
                    {foreground = "#f7b152"}}),
                },
            }),
        }))

        wilder.set_option("pipeline", {
            wilder.branch(
            wilder.cmdline_pipeline({
                language = "python",
                fuzzy = 1,
            }),
            wilder.python_search_pipeline({
                pattern = wilder.python_fuzzy_pattern(),
                sorter = wilder.python_difflib_sorter(),
                engine = "re",
            })
            ),
        })
    end
}
