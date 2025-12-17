-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  "Mofiqul/dracula.nvim",
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o",
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
      },
    },
    build = "make", -- Use "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" for Windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakoHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    {
      "xiyaowong/transparent.nvim",
    },
    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function() vim.fn["mkdp#util#install"]() end,
    },
    {"ellisonleao/glow.nvim", config = true, cmd = "Glow"}
  },
  {
    "dccsillag/magma-nvim",
    lazy = false,                    -- ensure it's loaded eagerly
    build = ":UpdateRemotePlugins",  -- run this command after installation
    config = function()
      -- Optional: Set up your keybindings for magma-nvim
      vim.keymap.set("n", "<LocalLeader>rr", ":MagmaEvaluateLine<CR>", { desc = "Evaluate current line" })
      vim.keymap.set("n", "<LocalLeader>r", ":MagmaEvaluateOperator<CR>", { desc = "Evaluate operator" })
      vim.keymap.set("v", "<LocalLeader>r", ":<C-u>MagmaEvaluateVisual<CR>", { desc = "Evaluate visual selection" })
      vim.keymap.set("n", "<LocalLeader>rc", ":MagmaReevaluateCell<CR>", { desc = "Reevaluate cell" })
      vim.keymap.set("n", "<LocalLeader>rd", ":MagmaDelete<CR>", { desc = "Delete cell" })
      vim.keymap.set("n", "<LocalLeader>ro", ":MagmaShowOutput<CR>", { desc = "Show cell output" })
      -- Additional configuration can be set here if needed.
    end,
  },
--   {
--     "miversen33/sunglasses.nvim",
--     config = true
--   }
}

lvim.colorscheme = "Dracula"

-- For autosave
vim.opt.autowrite = true
vim.opt.autowriteall = true

-- Numbering
vim.opt.number = true
vim.opt.relativenumber = true
