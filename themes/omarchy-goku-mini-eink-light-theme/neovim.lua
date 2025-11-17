return {
    {
        "bjarneo/aether.nvim",
        name = "aether",
        priority = 1000,
        opts = {
            disable_italics = false,
            colors = {
                -- Monotone shades (base00-base07)
                base00 = "#ffffff", -- Default background
                base01 = "#eb0404", -- Lighter background (status bars)
                base02 = "#ffffff", -- Selection background
                base03 = "#eb0404", -- Comments, invisibles
                base04 = "#000000", -- Dark foreground
                base05 = "#000000", -- Default foreground
                base06 = "#000000", -- Light foreground
                base07 = "#000000", -- Light background

                -- Accent colors (base08-base0F)
                base08 = "#ff0000", -- Variables, errors, red
                base09 = "#00147e", -- Integers, constants, orange
                base0A = "#745108", -- Classes, types, yellow
                base0B = "#000000", -- Strings, green
                base0C = "#000000", -- Support, regex, cyan
                base0D = "#f14b38", -- Functions, keywords, blue
                base0E = "#000000", -- Keywords, storage, magenta
                base0F = "#000000", -- Deprecated, brown/yellow
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
