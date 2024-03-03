local bo = vim.bo
local fn = vim.fn

--------------------------------------------------------------------------------

-- displays irregular indentation and linebreaks, displays nothing when all is good
-- selene: allow(high_cyclomatic_complexity)
local function irregularWhitespace()
    -- USER CONFIG
    -- filetypes and the number of spaces they use. Omit or set to nil to use tabs for that filetype.
    local spaceFiletypes = { python = 4, yaml = 2 }
    local ignoredFiletypes = { "css", "markdown", "gitcommit" }
    local linebreakType = "unix" ---@type "unix" | "mac" | "dos"

    -- vars & guard
    local usesSpaces = bo.expandtab
    local usesTabs = not bo.expandtab
    local brUsed = bo.fileformat
    local ft = bo.filetype
    local width = bo.tabstop
    if vim.tbl_contains(ignoredFiletypes, ft) or fn.mode() ~= "n" or bo.buftype ~= "" then return "" end

    -- non-default indentation setting (e.g. changed via indent-o-matic)
    local nonDefaultSetting = ""
    local spaceFtsOnly = vim.tbl_keys(spaceFiletypes)
    if
        (usesSpaces and not vim.tbl_contains(spaceFtsOnly, ft))
        or (usesSpaces and width ~= spaceFiletypes[ft])
        then
            nonDefaultSetting = " " .. tostring(width) .. "󱁐  "
        elseif usesTabs and vim.tbl_contains(spaceFtsOnly, ft) then
            nonDefaultSetting = " 󰌒 " .. tostring(width)(" ")
        end

        -- wrong or mixed indentation
        local hasTabs = fn.search("^\t", "nw") > 0
        local hasSpaces = fn.search("^ ", "nw") > 0
        -- exception, jsdocs: space not followed by "*"
        if bo.filetype == "javascript" then hasSpaces = fn.search([[^ \(\*\)\@!]], "nw") > 0 end
        local wrongIndent = ""
        if usesTabs and hasSpaces then
            wrongIndent = " 󱁐 "
        elseif usesSpaces and hasTabs then
            wrongIndent = " 󰌒 "
        elseif hasTabs and hasSpaces then
            wrongIndent = " 󱁐 + 󰌒 "
        end

        -- line breaks
        local linebreakIcon = ""
        if brUsed ~= linebreakType then
            if brUsed == "unix" then
                linebreakIcon = " 󰌑 "
            elseif brUsed == "mac" then
                linebreakIcon = " 󰌑 "
            elseif brUsed == "dos" then
                linebreakIcon = " 󰌑 "
            end
        end

        return nonDefaultSetting .. wrongIndent .. linebreakIcon
    end

    --------------------------------------------------------------------------------

    --- https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/components/branch/git_branch.lua#L118
    ---@nodiscard
    ---@return boolean
    local function isStandardBranch()
        -- checking via lualine API, to not call git outself
        local curBranch = require("lualine.components.branch.git_branch").get_branch()
        local notMainBranch = curBranch ~= "main" and curBranch ~= "master"
        local validFiletype = bo.filetype ~= "help" -- vim help files are located in a git repo
        local notSpecialBuffer = bo.buftype == ""
        return notMainBranch and validFiletype and notSpecialBuffer
    end

    --------------------------------------------------------------------------------

    local function selectionCount()
        local isVisualMode = fn.mode():find("[Vv]")
        if not isVisualMode then return "" end
        local starts = fn.line("v")
        local ends = fn.line(".")
        local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
        return " " .. tostring(lines) .. "L " .. tostring(fn.wordcount().visual_chars) .. "C"
    end

    --------------------------------------------------------------------------------

    ---improves upon the default statusline components by having properly working icons
    ---@nodiscard
    local function currentFile()
        local maxLen = 25

        local ext = fn.expand("%:e")
        local ft = bo.filetype
        local name = fn.expand("%:t")
        if ft == "octo" and name:find("^%d$") then
            name = "#" .. name
        elseif ft == "TelescopePrompt" then
            name = "Telescope"
        end

        local deviconsInstalled, devicons = pcall(require, "nvim-web-devicons")
        local ftOrExt = ext ~= "" and ext or ft
        if ftOrExt == "javascript" then ftOrExt = "js" end
        if ftOrExt == "typescript" then ftOrExt = "ts" end
        if ftOrExt == "markdown" then ftOrExt = "md" end
        if ftOrExt == "vimrc" then ftOrExt = "vim" end
        local icon = deviconsInstalled and devicons.get_icon(name, ftOrExt) or ""
        -- add sourcegraph icon for clarity
        if fn.expand("%"):find("^sg") then icon = "󰓁 " .. icon end

        -- truncate
        local nameNoExt = name:gsub("%.%w+$", "")
        if #nameNoExt > maxLen then name = nameNoExt:sub(1, maxLen) .. "…" .. ext end

        if icon == "" then return name end
        return icon .. " " .. name
    end

    --------------------------------------------------------------------------------

    ---get the alternate oldfile, accounting for non-existing files etc.
    ---@nodiscard
    ---@return string|nil path of oldfile, nil if none exists in all oldfiles
    local function altOldfile()
        local oldfile
        local i = 0
        repeat
            i = i + 1
            if i > #vim.v.oldfiles then return nil end
            oldfile = vim.v.oldfiles[i]
            local fileExists = vim.loop.fs_stat(oldfile) ~= nil
            local isCurrentFile = oldfile == fn.expand("%:p")
            local commitMsg = oldfile:find("COMMIT_EDITMSG$")
            local harpoonMenu = oldfile:find("harpoon%-menu$")
        until fileExists and not commitMsg and not isCurrentFile and not harpoonMenu
        return oldfile
    end

    local function altFileStatusline()
        local maxLen = 25
        local altFile = fn.expand("#:t")
        local curFile = fn.expand("%:t")
        local altPath = fn.expand("#:p")
        local curPath = fn.expand("%:p")
        local altOld = altOldfile()
        local name, icon = "", ""
        local altBufNr = vim.fn.bufnr("#")---@diagnostic disable-line: param-type-mismatch
        local specialFile = altBufNr > -1 and vim.api.nvim_buf_get_option(altBufNr, "buftype") or false
        local fileExists = vim.loop.fs_stat(altPath) ~= nil
        local hasAltFile = altFile ~= "" and altPath ~= curPath and (fileExists or specialFile)

        if hasAltFile then
            local ext = fn.expand("#:e")
            local altBufFt = vim.api.nvim_buf_get_option(fn.bufnr("#"), "filetype") ---@diagnostic disable-line: param-type-mismatch
            local ftOrExt = ext ~= "" and ext or altBufFt
            if ftOrExt == "javascript" then ftOrExt = "js" end
            if ftOrExt == "typescript" then ftOrExt = "ts" end
            if ftOrExt == "markdown" then ftOrExt = "md" end
            if ftOrExt == "vimrc" then ftOrExt = "vim" end
            local deviconsInstalled, devicons = pcall(require, "nvim-web-devicons")
            icon = deviconsInstalled and devicons.get_icon(altFile, ftOrExt) or "#"

            -- add sourcegraph icon for clarity
            if fn.expand("#"):find("^sg") then icon = "󰓁 " .. icon end

            if curFile == altFile then
                -- append parent of altfile
                local altParent = fn.expand("#:p:h:t")
                name = altParent .. "/" .. altFile
            else
                name = altFile
            end
        elseif altOld then
            icon = "󰋚"
            name = vim.fs.basename(altOld)
        else
            return "??"
        end

        -- truncate
        local nameNoExt = name:gsub("%.%w+$", "")
        if #nameNoExt > maxLen then
            local ext = name:match("%.%w+$")
            name = nameNoExt:sub(1, maxLen) .. "…" .. ext
        end

        return icon .. " " .. name
    end

    --------------------------------------------------------------------------------

    -- FIX Add missing buffer names for current file component
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lazy", "mason", "TelescopePrompt", "noice" },
        callback = function()
            local name = vim.fn.expand("<amatch>")
            name = name:sub(1, 1):upper() .. name:sub(2) -- capitalize
            pcall(vim.api.nvim_buf_set_name, 0, name)
        end,
    })


    -- nerdfont: powerline icons have the prefix 'ple-'
    local bottomSeparators = { left = "", right = "" }
    local topSeparators = { left = "", right = "" }
    local emptySeparators = { left = "", right = "" }

    local lualineConfig = {
        sections = {
            lualine_a = {
                { "branch", cond = isStandardBranch },
                { currentFile },
            },
            lualine_b = {
                { altFileStatusline() },
            },
            lualine_c = {
            },
            lualine_x = {
                {
                    "diagnostics",
                    symbols = { error = "󰅚 ", warn = " ", info = "󰋽 ", hint = "󰘥 " },
                },
                { irregularWhitespace },
            },
            lualine_y = {
                "diff",
            },
            lualine_z = {
                { selectionCount, padding = { left = 0, right = 1 } },
                "location",
            },
        },
        options = {
            refresh = { statusline = 1000 },
            ignore_focus = {
                "DressingInput",
                "DressingSelect",
                "ccc-ui",
            },
            globalstatus = true,
            component_separators = { left = "", right = "" },
            section_separators = bottomSeparators,
            theme = "base16",
        },
    }

    --------------------------------------------------------------------------------

    return {
        "nvim-lualine/lualine.nvim",
        lazy = false, -- load immediately so there is no flickering
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "SmiteshP/nvim-navic",
        },
        opts = lualineConfig,
    }
