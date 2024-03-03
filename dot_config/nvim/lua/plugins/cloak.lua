return {
    "laytan/cloak.nvim",
    opts = {
        enable = true,
        cloak_character = "*",
        hightlight_group = "Comment",
        patterns = {
            {
                file_pattern = {
                    ".env",
                    "wrangler.toml",
                    ".dev.vars",
                },
                cloak_pattern = ".+",
            },
        },
    },
}
