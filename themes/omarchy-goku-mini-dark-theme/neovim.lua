return {
    {
        "bjarneo/aether.nvim",
        name = "aether",
        priority = 1000,
        opts = {
            disable_italics = false,
            colors = {
                -- Monotone shades (base00-base07)
                base00 = "#2d2929", -- Default background
                base01 = "#9e9090", -- Lighter background (status bars)
                base02 = "#2d2929", -- Selection background
                base03 = "#9e9090", -- Comments, invisibles
                base04 = "#e1dada", -- Dark foreground
                base05 = "#ffffff", -- Default foreground
                base06 = "#ffffff", -- Light foreground
                base07 = "#e1dada", -- Light background

                -- Accent colors (base08-base0F)
                base08 = "#bfafaf", -- Variables, errors, red
                base09 = "#bfafaf", -- Integers, constants, orange
                base0A = "#d4c9c9", -- Classes, types, yellow
                base0B = "#c8baba", -- Strings, green
                base0C = "#c5b6b6", -- Support, regex, cyan
                base0D = "#ceae77", -- Functions, keywords, blue
                base0E = "#cfa279", -- Keywords, storage, magenta
                base0F = "#d4c9c9", -- Deprecated, brown/yellow
            },
        },
        config = function(_, opts)
            require("aether").setup(opts)
            vim.cmd.colorscheme("aether")

            -- Enable hot reload
            require("aether.hotreload").setup()
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "aether",
        },
    },
}
