vim.g.mapleader = " "

require('lazy').setup({
  -- Plugins
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'voldikss/vim-floaterm' },
  { 'stevearc/oil.nvim' },
  { 'nvim-neo-tree/neo-tree.nvim', branch = 'v3.x', dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim', 'nvim-tree/nvim-web-devicons' } },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-cmp' },  -- Ensure nvim-cmp is included
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'onsails/lspkind.nvim' },
  { 'hrsh7th/vim-vsnip' },
  { 'windwp/nvim-autopairs' },
  { 'EdenEast/nightfox.nvim' },
  { 'nvim-treesitter/nvim-treesitter' },
  { 'hoob3rt/lualine.nvim' },
  { 'MunifTanjim/nui.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'akinsho/bufferline.nvim', version = "v4.*", dependencies = { 'nvim-tree/nvim-web-devicons' } }, -- Bufferline
  { 'stevearc/conform.nvim' },
  -- Alpha.nvim
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.startify")

      dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
      }

      alpha.setup(dashboard.opts)
    end,
  },

  -- Noice.nvim
  {
    "folke/noice.nvim",
    dependencies = { 'nvim-lua/plenary.nvim', 'rcarriga/nvim-notify' },
    config = function()
      require("noice").setup({
        lsp = {
          progress = { enabled = true },
          hover = { enabled = true },
        },
        messages = {
          view = "notify",
          timeout = 3000,
        },
      })
    end,
  },

  -- Tagbar (alternative to nvim-navbuddy)
  {
    "preservim/tagbar",
    cmd = "TagbarToggle",
    config = function()
      vim.g.tagbar_width = 30
      vim.g.tagbar_autoclose = 1
      vim.g.tagbar_sort = 0
    end,
  },

  -- presence.nvim
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup({
        -- General options
        auto_update = true,
        neovim_image_text = "The One True Text Editor",
        main_image = "file",  -- Choose between 'neovim' or 'file'
        log_level = nil,  -- Set to 'debug', 'info', 'warn', 'error' if needed
        debounce_timeout = 10,
        enable_line_number = false,
        buttons = false,  -- Disable buttons to avoid the error
        show_time = true,  -- Enable timer
	client_id = "1314902038827630632", -- Custom client id	


        -- Rich Presence text options
        editing_text = "Editing %s",
        file_explorer_text = "Browsing %s",
        git_commit_text = "Committing changes",
        plugin_manager_text = "Managing plugins",
        reading_text = "Reading %s",
        workspace_text = "Working on %s",
        line_number_text = "Line %s out of %s",
      })
    end,
  }
})

-- General Settings
vim.cmd("colorscheme nightfox") -- Set Nightfox theme
vim.o.showmode = false
vim.wo.number = true

-- Oil.nvim Setup
require('oil').setup({
  use_default_keymaps = true,
  view_options = {
    show_hidden = true,
  },
})

-- Neo-tree Setup
require('neo-tree').setup({
  close_if_last_window = true,
  enable_diagnostics = false,
  window = { width = 30 },
  filesystem = { filtered_items = { visible = true } },

   {
    "stevearc/conform.nvim",
    config = function()
      -- Setup for conform.nvim
      require('conform').setup({
        formatters_by_ft = {
          python = { "ruff" },
          javascript = { "prettier" },
          lua = { "stylua" },
          html = { "prettier" },
          css = { "prettier" },
          json = { "prettier" },
          -- Add more as needed
        },
      })
    end,
  },
})

-- Mason Setup
require('mason').setup()
require('mason-lspconfig').setup({ ensure_installed = { 'pyright', 'ts_ls' } })
require('lspconfig').pyright.setup{}

-- Treesitter Setup
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'python', 'lua', 'javascript', 'typescript', 'html', 'css' },
  highlight = { enable = true },
  indent = { enable = true },
})

-- Autopairs
require('nvim-autopairs').setup({ check_ts = true })

-- Lualine
require('lualine').setup({
  options = {
    theme = 'carbonfox',
    section_separators = { '', '' },
    component_separators = { '', '' },
  },
})

-- Bufferline Setup
require("bufferline").setup({
  options = {
    separator_style = "slant", -- Stylish separator
    diagnostics = "nvim_lsp",
    always_show_bufferline = true,
    offsets = { { filetype = "neo-tree", text = "File Explorer", text_align = "center" } },
  },
})

-- Telescope
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<C-f>"] = require('telescope.builtin').find_files,
        ["<C-u>"] = require('telescope.builtin').live_grep,
      },
    },
  },
})

-- nvim-cmp Setup for LSP Recommendations
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'vsnip' },
  },
})

-- Keymaps
vim.api.nvim_set_keymap('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-\\>', ':FloatermToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>g', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tb', ':TagbarToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>bl', ':BufferLinePick<CR>', { noremap = true, silent = true }) -- Example bufferline command
vim.api.nvim_set_keymap('n', '<Leader>o', ':Oil<CR>', { noremap = true, silent = true }) -- Bind Oil to <Leader>o

-- BufWritePre
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",  -- Apply to all file types
  callback = function()
    -- Format the file before saving using conform.nvim
    require('conform').format()
  end,
})

