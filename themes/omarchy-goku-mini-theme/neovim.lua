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
                base01 = "#ece5e5", -- Lighter background (status bars)
                base02 = "#ffffff", -- Selection background
                base03 = "#ece5e5", -- Comments, invisibles
                base04 = "#584b4b", -- Dark foreground
                base05 = "#000000", -- Default foreground
                base06 = "#000000", -- Light foreground
                base07 = "#584b4b", -- Light background

                -- Accent colors (base08-base0F)
                base08 = "#a38b8b", -- Variables, errors, red
                base09 = "#a38b8b", -- Integers, constants, orange
                base0A = "#c2a6a6", -- Classes, types, yellow
                base0B = "#b49a9a", -- Strings, green
                base0C = "#b69b9b", -- Support, regex, cyan
                base0D = "#e7a95e", -- Functions, keywords, blue
                base0E = "#a78e8e", -- Keywords, storage, magenta
                base0F = "#c2a6a6", -- Deprecated, brown/yellow
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
