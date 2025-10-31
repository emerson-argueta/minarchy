return {
    {
        "bjarneo/aether.nvim",
        name = "aether",
        priority = 1000,
        opts = {
            disable_italics = false,
            colors = {
                -- Monotone shades (base00-base07)
                base00 = "#000000", -- Default background
                base01 = "#b9aeae", -- Lighter background (status bars)
                base02 = "#000000", -- Selection background
                base03 = "#b9aeae", -- Comments, invisibles
                base04 = "#dacbcb", -- Dark foreground
                base05 = "#e9d6cd", -- Default foreground
                base06 = "#e9d6cd", -- Light foreground
                base07 = "#dacbcb", -- Light background

                -- Accent colors (base08-base0F)
                base08 = "#e3bebe", -- Variables, errors, red
                base09 = "#ffc5c5", -- Integers, constants, orange
                base0A = "#f1cc9f", -- Classes, types, yellow
                base0B = "#f1c8c8", -- Strings, green
                base0C = "#c5b6b6", -- Support, regex, cyan
                base0D = "#ceae77", -- Functions, keywords, blue
                base0E = "#efd3c6", -- Keywords, storage, magenta
                base0F = "#f6dca5", -- Deprecated, brown/yellow
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
