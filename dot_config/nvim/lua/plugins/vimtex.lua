return {
    "lervag/vimtex",
    dependencies = {
        "xuhdev/vim-latex-live-preview",
    },
    config = function ()
        -- Enable filetype plugin and indent
        vim.cmd [[filetype plugin indent on]]

        -- Enable syntax features
        vim.cmd [[syntax enable]]

        -- Configure viewer options
        vim.g.vimtex_view_method = "zathura"
        vim.g.livepreview_previewer = "zathura"
        -- or
        -- vim.g.vimtex_view_general_viewer = "okular"
        -- vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"

        -- Configure compiler backend
        vim.g.vimtex_compiler_method = "latexrun"

        -- Configure local leader
        vim.g.maplocalleader = ","
    end
}
