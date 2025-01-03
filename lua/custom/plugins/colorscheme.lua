return {
  {
    'catppuccin/nvim',
    enabled = true,
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
    opts = {
      flavour = 'mocha',
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        dadbod_ui = true,
        gitsigns = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = {
          enabled = true,
          indentscope_color = 'lavender',
        },
        snacks = true,
        which_key = true,
      },
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
      },
      navic = { enabled = true, custom_bg = 'lualine' },
      neotest = true,
      neotree = true,
      noice = true,
      which_key = true,
      highlight_overrides = {
        mocha = function(mocha)
          return {
            CursorLine = { bg = 'NONE' },
            CursorLineNr = { fg = mocha.yellow },
            LineNrAbove = { fg = mocha.overlay1 },
            LineNrBelow = { fg = mocha.overlay1 },
          }
        end,
      },
    },
  },
  {
    'brenoprata10/nvim-highlight-colors',
    lazy = true,
    event = 'BufReadPost',
    opts = {
      enable_tailwind = true,
    },
  },
  {
    'scottmckendry/cyberdream.nvim',
    enabled = false,
    optional = true,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'cyberdream'
    end,
    opts = {
      transparent = true,
      theme = {
        overrides = function(colors)
          return {
            CursorLine = { bg = 'NONE' },
            CursorLineNr = { fg = colors.purple },
            LineNrAbove = { fg = colors.grey },
            LineNrBelow = { fg = colors.grey },
          }
        end,
      },
    },
  },
  {
    'rebelot/kanagawa.nvim',
    enabled = false,
    optional = true,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'kanagawa-wave'
    end,
    opts = {
      transparent = true,
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },
          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
    },
  },
  {
    'folke/tokyonight.nvim',
    enabled = false,
    optional = true,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
    opts = {
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
  },
  {
    'EdenEast/nightfox.nvim',
    enabled = false,
    optional = true,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'nightfox'
    end,
    opts = {
      transparent = false,
    },
  },
  {
    'rose-pine/neovim',
    enabled = false,
    optional = true,
    name = 'rose-pine',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'rose-pine'
    end,
    opts = {
      transparent = true,
    },
  },
  {
    'Mofiqul/dracula.nvim',
    enabled = false,
    optional = true,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'dracula'
    end,
    opts = {
      transparent = true,
    },
  },
  {
    'yorumicolors/yorumi.nvim',
    enabled = false,
    optional = true,
    init = function()
      vim.cmd.colorscheme 'yorumi'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
