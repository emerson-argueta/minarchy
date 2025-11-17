return {
    {
        "bjarneo/aether.nvim",
        name = "aether",
        priority = 1000,
        opts = {
            disable_italics = false,
            colors = {
                -- Monotone shades (base00-base07)
                base00 = "#09090e", -- Default background
                base01 = "#ffeb00", -- Lighter background (status bars)
                base02 = "#09090e", -- Selection background
                base03 = "#ffeb00", -- Comments, invisibles
                base04 = "#fdfdff", -- Dark foreground
                base05 = "#ffffff", -- Default foreground
                base06 = "#ffffff", -- Light foreground
                base07 = "#fdfdff", -- Light background

                -- Accent colors (base08-base0F)
                base08 = "#fffa00", -- Variables, errors, red
                base09 = "#bd00ff", -- Integers, constants, orange
                base0A = "#ffffff", -- Classes, types, yellow
                base0B = "#c3ecbf", -- Strings, green
                base0C = "#fffa00", -- Support, regex, cyan
                base0D = "#ff00a3", -- Functions, keywords, blue
                base0E = "#ffffff", -- Keywords, storage, magenta
                base0F = "#f500ff", -- Deprecated, brown/yellow
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
