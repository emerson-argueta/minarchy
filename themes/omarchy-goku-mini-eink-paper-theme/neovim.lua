return {
  {
    "bjarneo/aether.nvim",
    name = "aether",
    priority = 1000,
    opts = {
      disable_italics = false,
      colors = {
        -- Optimized for E-Ink (High Contrast / Light Background)
        base00 = "#ffffff", -- Default background (Pure White)
        base01 = "#e0e0e0", -- Lighter background (Light Gray for status bars)
        base02 = "#d0d0d0", -- Selection background (Visible but light)
        base03 = "#888888", -- Comments (Medium gray for legibility)
        base04 = "#494949", -- Dark foreground (UI elements)
        base05 = "#000000", -- Default foreground (Pure Black)
        base06 = "#000000", -- Light foreground
        base07 = "#f0f0f0", -- Extra light background

        -- Accent colors (Mapped to bold Grayscale/Deep Red)
        base08 = "#000000", -- Variables
        base09 = "#000000", -- Integers (Black is safer than red on E-Ink)
        base0A = "#000000", -- Classes
        base0B = "#000000", -- Strings
        base0C = "#000000", -- Support
        base0D = "#000000", -- Functions (Pure Black for max contrast)
        base0E = "#000000", -- Keywords
        base0F = "#000000", -- Deprecated
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
