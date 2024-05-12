return {
    "RRethy/base16-nvim",
    dependencies = { "f-person/auto-dark-mode.nvim" },
    config = function()
        local utils = require("auto-dark-mode.utils")
        local interval = 15000
        local theme_tabl =
        {
            ["Catppuccin Mocha"] = "catppuccin-mocha",
            ["Catppuccin Latte"] = "catppuccin-latte",
            ["Decay Green"] = "",
            ["Rosé Pine"] = "rose-pine",
            ["Material Sakura"] = "rose-pine-dawn",
            ["Frosted Glass"] = "catppuccin-latte",
            ["Gruvbox Retro"] = "gruvbox-dark-medium",
            ["Tokyo Night"] = "tokyo-night-storm",
        }

        local current = vim.g.colors_name
        local function check_and_change(sys_theme)
            if current ~= theme_tabl[sys_theme] then
                vim.cmd("colorscheme base16-" .. theme_tabl[sys_theme])
            end
        end

        local function get_system_theme()
            local cmd = "source /home/nakxkri/.local/share/bin/globalcontrol.sh && echo $hydeTheme"
            utils.start_job(cmd, {
                on_stdout = function(data)
                    print(data[1])
                    check_and_change(data[1])
                end,
            })
        end

        local system = vim.loop.os_uname().sysname
        if system == "Linux" then
            get_system_theme()
            vim.fn.timer_start(interval, function()
                get_system_theme()
            end, { ["repeat"] = -1 })
        end

    end,
}
